require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe RealClient do
  context "test" do
    it "test1" do
      c = RealClient.new
      res = c.test

      s = res.summary
      r = res.search

      expect(s.total_hits).to eq(1000)
      expect(c.size).to eq(100)

      doc = r.sources.first
      expect(doc["address"]).to eq("880 Holmes Lane")
      expect(doc["balance"]).to eq(39225)
    end
  end
end
