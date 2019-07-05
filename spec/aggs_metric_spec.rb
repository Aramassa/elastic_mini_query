require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe ElasticMiniQuery::Query::AggBuilder do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "aggregation" do
    context "Metrics Aggregation" do
      it "min, max, avg" do
        res = client.search("Street", [:address, :firstname]).agg_balance.execute
        s = res.summary
        a = res.aggs

        expect(s.total_hits).to eq(385)
        expect(a["aggs"]["balance_min"]).to eq(1031.0)
        expect(a["aggs"]["balance_max"]).to eq(49795.0)
      end
    end
    it "summary_by" do

    end

    context "date_histgram" do
      it "logstash-*" do
        res = client.agg_by_date.execute
        s = res.summary
        a = res.aggs

        expect(a["memory_by_date"].first["memory_max"]).to eq(397480.0)
        expect(a["memory_by_date"].first["memory_min"]).to eq(0.0)
        expect(a["memory_by_date"].first["memory_avg"]).to eq(201708.0)

        expect(a["memory_by_date"].last["memory_max"]).to eq(392800.0)
        expect(a["memory_by_date"].last["memory_min"]).to eq(0.0)
        expect(a["memory_by_date"].last["memory_avg"]).to eq(192077.31343283583)
      end

    end
  end
end