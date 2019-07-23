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
          q.date_range(:birthday, term_gte: Date.parse(term_gte).to_time.to_i) if term_gte
          res = q.execute
          s = res.summary
          a = res.aggs

          a["body_weight_by_date"].each_with_index do |v, k|
            next if k == 0
            if v["body_weight_min"]
              p v
              p k
              break
            end
          end

          expect(s.total_hits).to eq(hits)

          expect(a["body_weight_by_date"].size).to eq(size)

          expect(a["body_weight_by_date"][idx_one]["key_as_string"]).to eq(first_key)
          expect(a["body_weight_by_date"][idx_one]["body_weight_max"]).to eq(first_max)
          expect(a["body_weight_by_date"][idx_one]["body_weight_min"]).to eq(first_min)
          expect(a["body_weight_by_date"][idx_one]["body_weight_avg"]).to eq(first_avg)

          expect(a["body_weight_by_date"][idx_two]["body_weight_max"]).to eq(last_max)
          expect(a["body_weight_by_date"][idx_two]["body_weight_min"]).to eq(last_min)
          expect(a["body_weight_by_date"][idx_two]["body_weight_avg"]).to eq(last_avg)
        end
      end

      context "spcify interval" do
        it_behaves_like "interval_spec", :day do
          let(:term_gte){nil}
          let(:idx_one){0}
          let(:idx_two){2}
          let(:hits){500}
          let(:size){500}
          let(:first_key){"2016-10-16"}
          let(:first_max){83.33333333333334}
          let(:first_min){83.33333333333334}
          let(:first_avg){83.33333333333334}
          let(:last_max){83.4}
          let(:last_min){83.4}
          let(:last_avg){83.4}
        end

        it_behaves_like "interval_spec", :year do
          let(:term_gte){nil}
          let(:idx_one){0}
          let(:idx_two){0}
          let(:hits){500}
          let(:size){2}
          let(:first_key){"2016"}
          let(:first_max){92.96666666666667}
          let(:first_min){83.33333333333334}
          let(:first_avg){88.15}
          let(:last_max){92.96666666666667}
          let(:last_min){83.33333333333334}
          let(:last_avg){88.15}
        end

        it_behaves_like "interval_spec", :month do
          let(:term_gte){nil}
          let(:idx_one){0}
          let(:idx_two){0}
          let(:hits){500}
          let(:size){17}
          let(:first_key){"2016-10"}
          let(:first_max){83.83333333333334}
          let(:first_min){83.33333333333334}
          let(:first_avg){83.58333333333333}
          let(:last_max){83.83333333333334}
          let(:last_min){83.33333333333334}
          let(:last_avg){83.58333333333333}
        end

        it_behaves_like "interval_spec", :hour do
          let(:term_gte){"2016-01-01"}
          let(:idx_one){0}
          let(:idx_two){24}
          let(:hits){290}
          let(:size){6937}
          let(:first_key){"2016-10-16-00"}
          let(:first_max){83.33333333333334}
          let(:first_min){83.33333333333334}
          let(:first_avg){83.33333333333334}
          let(:last_max){83.36666666666667}
          let(:last_min){83.36666666666667}
          let(:last_avg){83.36666666666667}
        end

        it_behaves_like "interval_spec", :minute, timezone: "+09:00" do
          let(:term_gte){"2016-10-15"}
          let(:idx_one){0}
          let(:idx_two){1440}
          let(:hits){2}
          let(:size){1441}
          let(:first_key){"2016-10-16-09-00"}
          let(:first_max){83.33333333333334}
          let(:first_min){83.33333333333334}
          let(:first_avg){83.33333333333334}
          let(:last_max){83.36666666666667}
          let(:last_min){83.36666666666667}
          let(:last_avg){83.36666666666667}
        end

        it_behaves_like "interval_spec", :minute do
          let(:term_gte){"2016-10-15"}
          let(:idx_one){89}
          let(:idx_two){670}
          let(:hits){2}
          let(:size){1441}
          let(:first_key){"2016-10-15-22-31"}
          let(:first_max){nil}
          let(:first_min){nil}
          let(:first_avg){nil}
          let(:last_max){nil}
          let(:last_min){nil}
          let(:last_avg){nil}
        end
      end
    end
  end
end