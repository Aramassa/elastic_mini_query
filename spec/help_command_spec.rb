require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Help Command" do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "Help Command" do
    it "Execute for search" do
      res = client.get_all_docs.sort_by(_id: :asc, age: :desc).execute

      help = res.help
      expect(help).to include({
        summary: { :possible_keys => [:took, :timed_out, :total_hits, :total_hits_relation] }
      }, :search, :aggs)
    end
  end
end