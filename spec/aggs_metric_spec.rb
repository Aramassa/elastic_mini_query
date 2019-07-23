require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Aggregation for Metric" do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "aggregation" do
    context "Metrics Aggregation" do
      it "min, max, avg" do
        res = client.search("Good morning", [:introduction, :hobby]).agg_balance.execute
        s = res.summary
        a = res.aggs

        expect(s.total_hits).to eq(99)
        expect(a["aggs"]["age_min"]).to eq(6.0)
        expect(a["aggs"]["age_max"]).to eq(8.0)
      end
    end
  end
end