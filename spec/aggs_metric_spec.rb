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
        res = client.search("Street", [:address, :firstname]).agg_balance.execute
        s = res.summary
        a = res.aggs

        expect(s.total_hits).to eq(385)
        expect(a["aggs"]["balance_min"]).to eq(1031.0)
        expect(a["aggs"]["balance_max"]).to eq(49795.0)
      end
    end
  end
end