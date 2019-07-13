require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Indice Post / Mapping" do

  let!(:client) {
    RealClient.new
  }

  let!(:poster) {
    client.poster("example", "default")
  }

  describe "Mapping" do
    context "Register" do
      it "for example indices" do
        poster.mapping!({
          properties: {
            "name": {
              type: "keyword"
            },
            "email": {
              type: "keyword"
            },
            "introduction": {
              type: "text"
            },
            "age": {
              type: "integer"
            },
            "gender": {
              type: "keyword"
            },
            "married":{
              type: "boolean"
            },
            "body_weight": {
              type: "double"
            },
            "birthday": {
              type: "date",
              format: "strict_date_optional_time||epoch_millis"
            },
            "created_at": {
              type: "date",
              format: "epoch_second"
            }
          }
        })
      end
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

      it "add indice" do
        poster.post!("12345", {
          test: 'hello!!'
        })
      end
    end
  end
end