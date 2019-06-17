require_relative("lib/example_client")
require_relative("lib/example_client2")

RSpec.describe ElasticMiniQuery do
  it "has a version number" do
    expect(ElasticMiniQuery::VERSION).not_to be nil
  end

  it "initialize parameters" do
    client1 = ExampleClient.new
    client2 = ExampleClient2.new

    expect(client1.class.host).to eq("http://localhost:9200")
    expect(client2.class.host).to eq("http://localhost:9201")
  end
end
