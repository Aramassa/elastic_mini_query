module ElasticMiniQuery
  module Query
    class AggBuilder
      def initialize(type, name)
        @type = type
        @name = name

        @aggs = []
      end

      def agg(field, as, types)
        types = [types] unless types.is_a?(Array)
        @aggs << {
          field: field,
          as: as,
          types: types
        }

        self
      end
    end
  end
end
