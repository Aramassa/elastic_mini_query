require "lib/real_client"
require "date"

client = RealClient.new
poster = client.poster("user-001", "default")
poster.delete_index!
res    = poster.empty_index!

poster.template!("example-tpl", ["user-*", "sample-*"], {
  "name":      {
    type: "keyword"
  },
  "children":  {
    type: "integer"
  },
  "height":    {
    type: "double"
  },
  "host_name": {
    "type": "keyword"
  },
  "death_day": {
    type:   "date",
    format: "strict_date_optional_time||epoch_millis"
  },
  "address1":  {
    "type": "text"
  }
}, order: 30)

properties = {
  properties: {
    "email":        {
      type: "keyword"
    },
    "introduction": {
      type: "text"
    },
    "hobby":        {
      type: "text"
    },
    "history":      {
      type: "text"
    },
    "age":          {
      type: "integer"
    },
    "gender":       {
      type: "keyword"
    },
    "married":      {
      type: "boolean"
    },
    "body_weight":  {
      type: "double"
    },
    "birthday":     {
      type:   "date",
      format: "strict_date_optional_time||epoch_second"
    },
    "created_at":   {
      type:   "date",
      format: "epoch_second"
    }
  }
}

poster.mapping!(properties)

poster.sync do
  (1000...1500).each do |id|
    res = poster.post!(id, {
      name:         "name#{id} test#{id}",
      email:        "test+#{id}@test.com",
      age:          5 + (id % 15),
      married:      !!(((id / 3) % 2) == 0),
      gender:       !!(((id / 7) % 2) == 0) ? "male" : "female",
      body_weight:  50 + (id / 30.0),
      created_at:   Time.now.to_i,
      birthday: (Time.now.to_date - id).to_time.to_i,
      introduction: case id % 15
                      when 0
                        "Are you OK?, You alright?, or Alright mate?"
                      when 1, 2
                        "Good morning, Good afternoon, or Good evening"
                      when 3
                        "Good night!!"
                      else
                        "Hello. my name is Elastic!!"
                    end,
      hobby:        case id % 18
                      when 0
                        "baseball"
                      when 1, 2
                        "football swim"
                      when 3
                        "climbing guiter\npiano"
                      when 4
                        "football"
                      when 5
                        "judo"
                      else
                        "baseball swim"
                    end,
      history:      case id % 7
                      when 0
                        "good enough"
                      when 1, 2, 4, 5
                        "very bad"
                      when 3
                        "normal"
                      else
                        "nothing"
                    end
    })
  end
end
