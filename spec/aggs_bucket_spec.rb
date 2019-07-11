require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Aggregate with Bucket" do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "date_histgram" do
    context "logstash-*" do

      shared_examples "interval_spec" do |interval, timezone: nil|
        it "interval #{interval}" do
          q = client.agg_by_date(interval: interval, timezone: timezone)
          res = q.execute
          s = res.summary
          a = res.aggs

          expect(s.total_hits).to eq(hits)

          expect(a["memory_by_date"].size).to eq(size)

          expect(a["memory_by_date"][idx_one]["key_as_string"]).to eq(first_key)
          expect(a["memory_by_date"][idx_one]["memory_max"]).to eq(first_max)
          expect(a["memory_by_date"][idx_one]["memory_min"]).to eq(first_min)
          expect(a["memory_by_date"][idx_one]["memory_avg"]).to eq(first_avg)

          expect(a["memory_by_date"][idx_two]["memory_max"]).to eq(last_max)
          expect(a["memory_by_date"][idx_two]["memory_min"]).to eq(last_min)
          expect(a["memory_by_date"][idx_two]["memory_avg"]).to eq(last_avg)

          a["memory_by_date"].each_with_index do |v, k|
            if v["memory_max"]
              break
            end
          end
        end
      end

      context "spcify interval" do
        it_behaves_like "interval_spec", :day do
          let(:idx_one){0}
          let(:idx_two){2}
          let(:hits){14005}
          let(:size){3}
          let(:first_key){"2015-05-20"}
          let(:first_max){397480.0}
          let(:first_min){0.0}
          let(:first_avg){201708.0}
          let(:last_max){392800.0}
          let(:last_min){0.0}
          let(:last_avg){192077.31343283583}
        end

        it_behaves_like "interval_spec", :year do
          let(:idx_one){0}
          let(:idx_two){0}
          let(:hits){14005}
          let(:size){1}
          let(:first_key){"2015"}
          let(:first_max){397480.0}
          let(:first_min){0.0}
          let(:first_avg){195742.6700251889}
          let(:last_max){397480.0}
          let(:last_min){0.0}
          let(:last_avg){195742.6700251889}
        end

        it_behaves_like "interval_spec", :month do
          let(:idx_one){0}
          let(:idx_two){0}
          let(:hits){14005}
          let(:size){1}
          let(:first_key){"2015-05"}
          let(:first_max){397480.0}
          let(:first_min){0.0}
          let(:first_avg){195742.6700251889}
          let(:last_max){397480.0}
          let(:last_min){0.0}
          let(:last_avg){195742.6700251889}
        end

        it_behaves_like "interval_spec", :hour do
          let(:idx_one){2}
          let(:idx_two){40}
          let(:hits){14005}
          let(:size){72}
          let(:first_key){"2015-05-20-21"}
          let(:first_max){376520.0}
          let(:first_min){157320.0}
          let(:first_avg){266920.0}
          let(:last_max){331480.0}
          let(:last_min){5040.0}
          let(:last_avg){148752.0}
        end

        it_behaves_like "interval_spec", :minute, timezone: "+09:00" do
          let(:idx_one){89}
          let(:idx_two){670}
          let(:hits){14005}
          let(:size){4281}
          let(:first_key){"2015-05-21-07-00"}
          let(:first_max){160800.0}
          let(:first_min){160800.0}
          let(:first_avg){160800.0}
          let(:last_max){312520.0}
          let(:last_min){312520.0}
          let(:last_avg){312520.0}
        end

        it_behaves_like "interval_spec", :minute do
          let(:idx_one){89}
          let(:idx_two){670}
          let(:hits){14005}
          let(:size){4281}
          let(:first_key){"2015-05-20-22-00"}
          let(:first_max){160800.0}
          let(:first_min){160800.0}
          let(:first_avg){160800.0}
          let(:last_max){312520.0}
          let(:last_min){312520.0}
          let(:last_avg){312520.0}
        end
      end
    end
  end
end