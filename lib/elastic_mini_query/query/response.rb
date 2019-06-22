require "json"

module ElasticMiniQuery
  module Query
    class Response
      def initialize(raw)
        @raw = raw
        @summary, @search, @agg = @raw.parse
      end

      def summary
        @summary
      end

      def search
        @search
      end

      def agg
        @agg
      end
    end
  end
end
