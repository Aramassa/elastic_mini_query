# Usage

## Initialize Query Class

```ruby
class ElasticSimpleQuery < ElasticMiniQuery::Client::Base
  elastic_mini_host "http://localhost:9200"
  elastic_mini_api_key "some api key"

end

client = ElasticSimpleQuery.new
```

## Search

* all columns

```ruby
client.match("word")
```

* specify columns

```ruby
## Single
client.match("word", :address)

## Multiple
client.match("word", [:address, :name])
```

* multiple words

```ruby
## Match any words
client.match_any("word1 word2 word3")
client.match_any(["word1" "word2" "word3"]) # array
client.match_any("word1 word2 word3", :address) # specify column

## Match all words
client.match_all("word1 word2 word3")
client.match_any(["word1" "word2" "word3"]) # array
client.match_any("word1 word2 word3", :address) # specify column
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
