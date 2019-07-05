require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe ElasticMiniQuery::Error do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "indice not exists" do
    context "raise exception" do
      it "indice not exists" do
        expect{client.empty_index.execute!}.to raise_error(ElasticMiniQuery::ResponseError)
      end
    end

    context "not raise exception" do
      it "indice not exists" do
        res = client.empty_index.execute

        expect(res.error?).to eq(true)
        s = res.summary
        expect(s.total_hits).to eq(0)

        expect(res.error.reason).to eq("no such index [not-exists]")
        expect(res.error.type).to eq("index_not_found_exception")
      end
    end
  end

end