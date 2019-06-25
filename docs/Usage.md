# Usage

## Initialize Query Class

```ruby
class ElasticSimpleQuery < ElasticMiniQuery::Client::Base
  elastic_mini_host "http://localhost:9200"
  elastic_mini_api_key "some api key"

end

esq = ElasticSimpleQuery.new
```

## Search

* all columns

```ruby
esq.q("hello")
```

* specify columns

```ruby
esq.q("hello", columns: ["col_a", "col_b"])
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
