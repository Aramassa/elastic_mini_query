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
  let(:dummy_response) do
    ElasticMiniQuery::Query::Response.new(raw_response_v71)
  end

  let(:raw_response_v71) do
    File.open("spec/testdata/query_response_v71.json") do |j|
      ElasticMiniQuery::Result::Raw.new(j.read)
    end
  end

  context "parsing raw result" do
    it "basic query" do
      res = dummy_response
      expect(res.summary.took).to eq(13)
      expect(res.summary.total_hits).to eq(40318)
      expect(res.summary.timed_out).to be_falsey
    end
  end
end

RSpec.describe ElasticMiniQuery::Result::Summary do
  context "Attribute Method" do
    let(:summary){
      ElasticMiniQuery::Result::Summary.new
    }

    it "assign total_hits" do
      summary.total_hits = 300

      count = summary.total_hits
      expect(count).to eq(300)
    end

    it "assign total_hits_relation" do 
      summary.total_hits_relation = :eq

      expect(summary.total_hits_relation).to eq(:eq)
    end

    it "assign timed_out" do
      summary.timed_out = false
      expect(summary.timed_out).to be_falsy

      summary.timed_out = true
      expect(summary.timed_out).to be_truthy
    end
  end
end
