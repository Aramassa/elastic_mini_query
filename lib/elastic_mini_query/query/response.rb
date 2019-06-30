require "json"

module ElasticMiniQuery
  module Query
    class Response
      def initialize(raw)
        @raw = raw
        @summary, @search, @aggs = @raw.parse
      end

      ##
      # @return ElasticMiniQuery::Result::Summary
      def summary
        @summary
      end

      def search
        @search
      end

      def aggs
        @aggs
      end
    end
  end
end
