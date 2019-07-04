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

      def aggs(type=nil)
        agg = ElasticMiniQuery::Query::AggBuilder.new(type)
        @aggs << agg

        agg
      end

      def parser_keys
        @aggs.map(&:parser_keys).to_h
      end

      def to_json
        req = {
          size: @size,
          track_total_hits: @track_total_hits
        }

        if @query
          req[:query] = @query.to_json
        end

        @aggs.each do |agg|
          req[:aggs] ||= {}
          agg.kv(req[:aggs])
        end

        req.to_json
      end
    end
  end
end
