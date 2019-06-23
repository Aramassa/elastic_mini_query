require_relative("lib/example_client")
require_relative("lib/example_client2")

require "json"

RSpec.describe ElasticMiniQuery do
  it "has a version number" do
    expect(ElasticMiniQuery::VERSION).not_to be nil
  end

  context "Setting" do
    it "initialize parameters" do
      client1 = ExampleClient.new
      client2 = ExampleClient2.new
  
      expect(client1.class.elastic_mini_host).to eq("http://localhost:9200")
      expect(client2.class.elastic_mini_host).to eq("http://localhost:9201")
    end
  end
end

RSpec.describe ElasticMiniQuery::Query::Response do
  let(:search1) do
    ElasticMiniQuery::Query::Response.new(raw_response_v71)
  end

  let(:raw_response_v71) do
    File.open("spec/testdata/query_response_v71.json") do |j|
      ElasticMiniQuery::Result::Raw.new(j.read)
    end
  end

  context "parsing raw result" do
    it "basic search query" do
      res = search1
      s = res.summary

      expect(s.took).to eq(13)
      expect(s.total_hits).to eq(40318)
      expect(s.total_hits_relation).to eq("eq")
      expect(s.timed_out).to be_falsey

      r = res.search
      expect(r.hits.count).to eq(200)
      expect(r.hits.first["_id"]).to eq("201905210114")
      expect(r.sources.first["CADJPY_max"]).to eq("82.0265")
    end

    it "basic aggregatino query" do

    end
  end
end
