require "elastic_mini_query/result/agg_item"

module ElasticMiniQuery::Result
  class AggResult

    def initialize(aggs, parser_keys)
      @metrics = {}
      return if aggs.nil?
      @aggs = aggs

      parser_keys.each do |top_field, keys|
        child = top_field == "aggs" ? aggs : aggs[top_field.to_s]
        @metrics[top_field] = parse_agg(child, keys, {})
      end
    end

    def val(aggs, keys)
      keys.map do |k|
        v = if aggs[k].is_a?(Hash) && aggs[k]["value"]
              aggs[k]["value"]
            else
              aggs[k]
            end
        [k, v]
      end.to_h
    end

    def parse_agg(aggs, keys, result)
      return if keys.nil?
      case keys
        when Array
          if aggs.is_a? Array
            return aggs.map{|agg| val(agg, keys)}
          else
            return val(aggs, keys)
          end
        when Hash
          keys.each do |k, v|
            return parse_agg(aggs[k.to_s], v, {})
          end
        else

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
