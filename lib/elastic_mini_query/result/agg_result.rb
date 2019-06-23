require "elastic_mini_query/result/agg_item"

module ElasticMiniQuery::Result
  class AggResult

    attr_accessor :aggregations

    def aggs(name)
      @aggregations[name]["buckets"]
    end
  end
end
