require "json"

module ElasticMiniQuery
  module Query
    class Response
      def initialize(raw)
        @raw = raw
        @summary, @search, @aggs, @error = @raw.parse
      end

      ##
      #
      #
      def help
        {
          summary: {
            possible_keys: @summary.possible_keys
          },
          search: {
            possible_keys: "not implemented" # @TODO add possiblekeys
          },
          aggs: {
            possible_keys: "not implemented" # @TODO add possiblekeys
          }
        }
      end

      def help!
        puts help
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

      def error?
        !@error.nil?
      end

      def error
        @error
      end
    end
  end
end
