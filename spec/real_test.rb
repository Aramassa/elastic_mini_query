require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe RealClient do
  context "test" do
    it "test1" do
      hoge = RealClient.test
      p hoge
    end
  end
end
