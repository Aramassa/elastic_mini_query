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

      p s.total_hits
      p c.size

      r.sources.each do |row|
        p row["USDJPY_min"]
      end
    end
  end
end
