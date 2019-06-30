require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe RealClient do

  let!(:client) {
    RealClient.new
  }

  context "get all data" do
    it "get all data" do
      res = client.get_all_docs

      s = res.summary
      r = res.search

      expect(s.total_hits).to eq(1000)
      expect(client.size).to eq(100)

      doc = r.sources.first
      expect(doc["address"]).to eq("880 Holmes Lane")
      expect(doc["balance"]).to eq(39225)
    end
  end

  context "String search" do

    it "search all field" do
      res = client.search("Fulton")
      s = res.summary

      expect(s.total_hits).to eq(3)
    end

    it "search by bank address" do
      c = RealClient.new
      res = client.search_by_address("Street")
      s = res.summary

      expect(s.total_hits).to eq(385)

      res = client.search_by_address("Bristol")
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
