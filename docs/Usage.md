# Usage

## Initialize Query Class

```ruby
class ElasticSimpleQuery < ElasticMiniQuery::Client::Base
  elastic_mini_host "http://localhost:9200"
  elastic_mini_api_key "some api key"

  ## request all data
  def get_all_docs
    request do |builder|
      builder.indices = "bank"
    end
  end
end

client = ElasticSimpleQuery.new
```

## Create Index / Mapping / Templaste

|Operation|Compatibility|
|---|---|
|Mapping|URL Only (Body not compatible)|
|Template|URL Only (Body not compatible)|
|POST to Index|Nothing|

### Mapping

```ruby
poster.mapping!({
  properties: {
    "name": {
      type: "keyword"
    }
  }
})
```

### Template

```ruby
poster.templaste!("example-tpl", ["example-*", "sample-*"], {
  "name": {
    type: "keyword"
  },
  "host_name": {
   "type": "keyword"
  }
}, order: 30)
```

* options
  * order : adapt priority

### Indice

* create empty index

```ruby
poster.empty_index!
````

## String Match

* all columns

```ruby
build do |builder|
  builder.indices = "bank"
end
```

* specify columns

```ruby
## Single
build do |builder|
  builder.indices = "bank"
  builder.query.match("word", :address)
end

## Multiple
build do |builder|
  builder.indices = "bank"
  builder.query.match("word", [:address, :firstname])
end
```

* multiple words

```ruby
## Match any words
build do |builder|
  builder.indices = "bank"
  builder.query.match("word1 word2 word3").match_any
end 

## Phrase Match
build do |builder|
  builder.indices = "bank"
  builder.query.match("word1 word2 word3").match_phrase
end  
```

## Aggregation

### Metric Aggregations

```ruby
build do |builder|
  builder.indices = "bank"
  builder.aggs.agg(:balance, [:max, :avg, :min])
end
```

### Bucket Aggregations

#### Date Histogram

```ruby
build do |builder|
  builder.indices = "bank"
  builder.aggs.agg(:balance, [:max, :avg, :min])
    .date_histogram("@timestamp", :day, order: :desc, format: 'yyyy-MM-dd')
end
```

* options

|Option|Description|Type|Value|
|---|---|---|---|
|timezone|set timezone offset for "key_as_string"|String|"+09:00"|
|order| |Symbol|:desc / :asc |

## fetch responses

```ruby
res = esq.get_all_docs.execute
res.docs.each do |row, info|
  # data processing
end

## other fetch methods.
res.fetch_all
res.fetch_page
```

### Response Types

```ruby
res = esq.q("hello")

class QueryResponse
```

#### Query Information

```ruby
info = res.info

class ResponseSummary
```

#### Search Results

```ruby
search_result = res.docs
class SearchResult
```

#### Aggregation Results

```ruby
aggregation_result = res.aggs
class AggResult
```
