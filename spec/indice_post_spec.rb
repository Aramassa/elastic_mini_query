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
        poster.template!("example-tpl", ["example-*", "sample-*"], {
          "name": {
            type: "keyword"
          },
          "host_name": {
            "type": "keyword"
          }
        }, order: 30)
      end
    end
  end

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

      it "create empty index" do
        res = client.poster("example-#{Time.now.to_i}", "default").empty_index!
        expect(res.status).to eq(200)
      end

      it "add indice" do
        (100...120).each do |id|
          poster.post!(id, {
            name: "test_#{id}",
            email: "test#{id}@test.com",
            age: 5 + (id % 15),
            married: !!(((id / 3) % 2) == 0),
            gender: !!(((id / 7) % 2) == 0) ? "male" : "female",
            body_weight: 50 + (id / 30.0),
            created_at: Time.now.to_i,
            introduction: case id % 5
                            when 0
                              "Are you OK?, You alright?, or Alright mate?"
                            when 1, 2
                              "Good morning, Good afternoon, or Good evening"
                            else
                              "Hello. my name is Elastic!!"
                          end
          })
        end
      end
    end
  end
end