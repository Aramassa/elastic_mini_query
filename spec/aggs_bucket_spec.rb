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

      shared_examples "interval_spec" do |interval|
        it "interval #{interval}" do
          res = client.debug!.agg_by_date(interval: interval).execute
          s = res.summary
          a = res.aggs

          expect(s.total_hits).to eq(hits)

          expect(a["memory_by_date"].size).to eq(size)

          expect(a["memory_by_date"].first["key_as_string"]).to eq(first_key)
          expect(a["memory_by_date"].first["memory_max"]).to eq(first_max)
          expect(a["memory_by_date"].first["memory_min"]).to eq(first_min)
          expect(a["memory_by_date"].first["memory_avg"]).to eq(first_avg)

          expect(a["memory_by_date"].last["memory_max"]).to eq(last_max)
          expect(a["memory_by_date"].last["memory_min"]).to eq(last_min)
          expect(a["memory_by_date"].last["memory_avg"]).to eq(last_avg)
        end
      end

      context "spcify interval" do
        it_behaves_like "interval_spec", :day do
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

        # it_behaves_like "interval_spec", :hour do
        #   let(:hits){14005}
        #   let(:size){72}
        #   let(:first_key){"2015-05-20-11"}
        #   let(:first_max){397480.0}
        #   let(:first_min){0.0}
        #   let(:first_avg){195742.6700251889}
        #   let(:last_max){397480.0}
        #   let(:last_min){0.0}
        #   let(:last_avg){195742.6700251889}
        # end
      end
    end
  end
end