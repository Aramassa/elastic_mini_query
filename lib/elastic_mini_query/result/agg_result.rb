require "elastic_mini_query/result/agg_item"

module ElasticMiniQuery::Result
  class AggResult

    attr_accessor :aggregations

    def aggs(bucket)
      return @items if @items
      @items = []
      each_item(bucket) do |item|
        @items << item
      end

      @items
    end

    def each(bucket)
      each_item(bucket) do |item|
        yield item
      end
    end

    private

    def each_item(bucket)
      @aggregations[bucket]["buckets"].each do |item|
        yield ElasticMiniQuery::Result::AggItem.new(item)
      end
    end
  end
end
