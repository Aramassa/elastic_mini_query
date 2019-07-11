module ElasticMiniQuery
  module Query
    class AggBuilder
      def initialize(type)
        @date_histogram = nil
        @type = type
        @field = nil
        @types = []

        @agg = {}

        @timezone_offset = nil
      end

      def agg(field, types)
        types = [types] unless types.is_a?(Array)
        @field = field
        @types = types

        self
      end

      ##
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.1/search-aggregations-bucket-datehistogram-aggregation.html
      #
      # @param field [String]
      # @param interval [Symbol]
      # @param order [Symbol]
      # @param format [String]
      #
      def date_histogram(field, interval, order: :asc, format: nil, timezone: nil)
        format = case interval
                   when !format.nil?
                   when :year then "yyyy"
                   when :month then "yyyy-MM"
                   when :day then "yyyy-MM-dd"
                   when :hour then "yyyy-MM-dd-HH"
                   when :minute then "yyyy-MM-dd-HH-mm"
                 end
        @date_histogram = {
          field: field,
          interval: interval
        }

        @date_histogram[:order] = {_key: order} if order
        @date_histogram[:format] = format if format
        @date_histogram[:time_zone] = timezone if timezone
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
              aggs: (@types.map do |type|
                ary = [
                  "#{@field}_#{type}",
                  {"#{type}": {field: @field}}
                ]
                ary << {time_zone: @timezone_offset} if @timezone_offset
                ary
              end.to_h)
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
