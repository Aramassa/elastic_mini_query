module ElasticMiniQuery
  module Query
    class AggBuilder
      def initialize(type)
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

      def kv(aggs)
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
