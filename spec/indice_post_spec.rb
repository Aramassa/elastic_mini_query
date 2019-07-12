require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Aggregation for Metric" do

  let!(:client) {
    RealClient.new
  }

  it "hoge" do
    poster = client.poster("hello", "default")
    poster.post!("12345", {
      test: 'hello!!'
    })
  end

end