require_relative "agg_builder"
require_relative "search_builder"

module ElasticMiniQuery
  module Query
    class Builder
      attr_accessor :indices
      attr_writer :size, :track_total_hits
      def initialize
        @searches = []
        @aggs = []

        @indice = "*"
      end

      def agg(type, name)
        agg = ElasticMiniQuery::Query::AggBuilder.new(type, name)
        @aggs << agg

        agg
      end

      def to_json
        req = {
          size: @size,
          track_total_hits: @track_total_hits
        }

        req.to_json
      end
    end
  end
end
