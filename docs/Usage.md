# Usage

## Initialize Query Class

```ruby
class ElasticSimpleQuery < ElasticMiniQuery
  es_host: "http://localhost:9200"
  es_api_key: "some api key"

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
res.each do |row, info|
  # data processing
end

## other fetch methods.

res.each_all
res.fetch_page
```

### Response Types

#### Query Information


#### Search Results


#### Aggregation Results
