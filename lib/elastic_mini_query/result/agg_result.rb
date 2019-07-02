require "elastic_mini_query/result/agg_item"

module ElasticMiniQuery::Result
  class AggResult

    def initialize(aggs)
      @metrics = {}
      return if aggs.nil?
      @aggs = aggs

      @aggs.each do |k, v|
        if @aggs[k]["value"]
          @metrics[k] = @aggs[k]["value"]
        end
      end
    end

    def [](key)
      @metrics[key]
    end

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
