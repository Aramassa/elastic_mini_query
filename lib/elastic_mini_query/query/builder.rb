require_relative "agg_builder"
require_relative "search_builder"

module ElasticMiniQuery
  module Query
    class Builder
      def initialize
        @searches = []
        @aggs = []
      end

      def agg(type, name)
        agg = ElasticMiniQuery::Query::AggBuilder.new(type, name)
        @aggs << agg

        agg
      end
    end
  end
end
