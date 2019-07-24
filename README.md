# ElasticMiniQuery

TODO: Write concept.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_mini_query'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_mini_query

## Compatibility

* elasticsearch version

|elasticsearch version| |status|
|---|---|---|
|0.90|→|not implemented|
|1.x|→|not implemented|
|2.x|→|not implemented|
|5.x|→|yet|
|6.x|→|yet|
|7.x|→|compatible|

## Basic Usage

### Search and Aggregation

Show [Usage.md](https://github.com/[USERNAME]/elastic_mini_query/blob/master/docs/Usage.md).

## Supported ElasticSearch functionss

### Search

See [ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/search.html)
See [ElasticSaerch](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/query-dsl.html)

|Search Type|Supported|Since|
|---|---|---|

### Metric Aggregation

See [ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/search-aggregations-metrics.html)

|Aggragation Type|Supported|Since|
|---|---|---|
|avg|Yes|0.1.0|
|min|Yes|0.1.0|
|max|Yes|0.1.0|

### Bucket Aggregation

See [ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/search-aggregations-bucket.html)

|Aggragation Type|Supported|Since|
|---|---|---|
|Date Histogram|Yes|0.1.0|
|Filter|in progress|0.1.0|  
|Filters|in progress|0.1.0|  
|Date Range|Yes|0.1.0|  
|Histogram|Yes|0.1.0|  


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Test

```sh
bundle exec rspec
```

Or with docker-compose(recommended)

```sh
docker-compose -f docker-compose.yml -f docker-compose/rspec.yml run app
```

#### Loading Sample Data

* 7.x

```sh
docker-compose exec elasticsearch /es_scripts/7.x.start.sh
```

See: https://www.elastic.co/guide/en/kibana/7.1/tutorial-load-dataset.html

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Aramassa/elastic_mini_query. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ElasticMiniQuery project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Aramassa/elastic_mini_query/blob/master/CODE_OF_CONDUCT.md).
