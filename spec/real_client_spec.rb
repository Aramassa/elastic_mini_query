require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe RealClient do

  context "get all data" do
    it "get all data" do
      c = RealClient.new
      res = c.get_all_docs

      s = res.summary
      r = res.search

      expect(s.total_hits).to eq(1000)
      expect(c.size).to eq(100)

      doc = r.sources.first
      expect(doc["address"]).to eq("880 Holmes Lane")
      expect(doc["balance"]).to eq(39225)
    end

    it "search all field" do
      c = RealClient.new
      res = c.search("Fulton")
      s = res.summary

      expect(s.total_hits).to eq(3)
    end

    it "search by bank address" do
      c = RealClient.new
      res = c.search_by_address("Street")
      s = res.summary

      expect(s.total_hits).to eq(385)

      res = c.search_by_address("Bristol")
      s = res.summary

      expect(s.total_hits).to eq(1)

    end
  end

  context "aggregation" do
    it "summary_by" do

    end

    it "date_histgram" do
    end
  end
end
