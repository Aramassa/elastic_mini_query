require_relative("lib/example_client")
require_relative("lib/example_client2")

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
