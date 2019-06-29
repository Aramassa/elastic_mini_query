require_relative "agg_builder"
require_relative "search_builder"

module ElasticMiniQuery
  module Query
    class Builder
      attr_accessor :indices
      attr_writer :size, :track_total_hits
      def initialize
        @searches = []
        @query = nil
        @aggs = []

        @indice = "*"
      end

      def query
        @query ||= ElasticMiniQuery::Query::SearchBuilder.new
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

        if @query
          req[:query] = @query.to_json
        end


        req.to_json
      end
    end
  end
end
