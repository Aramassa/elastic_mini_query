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

## String Match

* all columns

```ruby
request do |builder|
  builder.indices = "bank"
end
```

* specify columns

```ruby
## Single
request do |builder|
  builder.indices = "bank"
  builder.query.match("word", :address)
end

## Multiple
request do |builder|
  builder.indices = "bank"
  builder.query.match("word", [:address, :firstname])
end
```

* multiple words

```ruby
## Match any words
request do |builder|
  builder.indices = "bank"
  builder.query.match("word1 word2 word3").match_any
end 

## Phrase Match
request do |builder|
  builder.indices = "bank"
  builder.query.match("word1 word2 word3").match_phrase
end  
```

## Aggregation

```ruby
esq.agg
  .by_date(:day, format: 'YYYY-mm-dd')
  .filter(...)
  .agg("col_a", type: [:min, :max, :avg])
```

## fetch responses

```ruby
res = esq.q("hello")
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
