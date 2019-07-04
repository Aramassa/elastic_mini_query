module ElasticMiniQuery
  module Query
    class AggBuilder
      def initialize(type)
        @date_histogram = nil
        @type = type
        @field = nil
        @types = []

        @agg = {}
      end

      def agg(field, types)
        types = [types] unless types.is_a?(Array)
        @field = field
        @types = types

        self
      end

      def date_histgram(field, interval, order: :asc)
        @date_histogram = {
          field: field,
          interval: interval
        }

        @date_histogram[:order] = {_key: order}if order
      end

      def parser_keys
        case
          when @date_histogram
            return ["#{@field}_by_date", {
                "buckets": %w|
                  key_as_string
                  doc_count
                | + @types.map{|type| "#{@field}_#{type}"}
              }]
          else
            return ["aggs", @types.map{|type| "#{@field}_#{type}"}]
        end
      end

      def kv(aggs)
        case
          when @date_histogram
            aggs["#{@field}_by_date"] = {
              "date_histogram": @date_histogram,
              aggs: (@types.map{|type| ["#{@field}_#{type}", {"#{type}": {field: @field}}] }).to_h
            }
          else
            @types.each do |type|
              aggs["#{@field}_#{type}"] = {
                "#{type}": {
                  "field": @field
                }
              }
            end
        end
      end
    end
  end
end
