require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Indice Post / Mapping" do

  let!(:client) {
    RealClient.new
  }

  let!(:poster) {
    poster = client.poster("example", "default")
    res = poster.empty_index!

    poster
  }

  describe "Templaste" do
    context "Create" do
      it "for example template" do

      end
    end
  end

  describe "Mapping" do
    context "Register" do
    end

    context "Error" do
      context "Request" do

      end

      context "Mapping Parameters" do
        it "invalid type" do
          expect do
            begin
              poster.mapping!({
                properties: {
                  "email": {
                    type: "hogeword"
                  }
                }
              })
            rescue => e
              expect(e.error.type).to eq("mapper_parsing_exception")
              expect(e.error.reason).to eq("No handler for type [hogeword] declared on field [email]")
              raise e
            end
          end.to raise_error(ElasticMiniQuery::ResponseError)
        end
      end
    end
  end

  describe "Indice" do
    context "Post" do

      it "create empty index" do
        res = client.poster("example-#{Time.now.to_i}", "default").empty_index!
      end

      it "add indice" do
      end
    end
  end
end