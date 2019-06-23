require "json"

module ElasticMiniQuery
  module Query
    class Response
      def initialize(raw)
        @raw = raw
        @summary, @search, @aggs = @raw.parse
      end

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
