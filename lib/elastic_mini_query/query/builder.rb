require_relative "agg_builder"
require_relative "search_builder"

module ElasticMiniQuery
  module Query
    class Builder
      attr_reader :indice
      attr_writer :size, :track_total_hits
      def initialize(indice: "*")
        @searches = []
        @aggs = []

        @indice = indice
      end

      def agg(type, name)
        agg = ElasticMiniQuery::Query::AggBuilder.new(type, name)
        @aggs << agg

        agg
      end

      def to_json
        {
          size: @size,
          track_total_hits: @track_total_hits
        }.to_json
      end
    end
  end
end
