require "lib/real_client"

client = RealClient.new
poster = client.poster("user", "default")
res = poster.empty_index!

poster.template!("example-tpl", ["example-*", "sample-*"], {
  "name": {
    type: "keyword"
  },
  "children": {
    type: "integer"
  },
  "height": {
    type: "double"
  },
  "host_name": {
    "type": "keyword"
  },
  "death_day": {
    type: "date",
    format: "strict_date_optional_time||epoch_millis"
  },
  "address1": {
    "type": "text"
  }
}, order: 30)

properties = {
  properties: {
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
}

poster.mapping!(properties)

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
