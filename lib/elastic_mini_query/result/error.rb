module ElasticMiniQuery
  module Result
    class Error
      attr_reader :type, :reason

      def initialize(es_response_text, parser_keys)
        @es_response_text = es_response_text
      end

      ##
      # @param ElasticMiniQuery::Query::Response response
      #
      def parse
        return @summary, @search, @agg unless @parse_result.nil?
        @parser = ElasticMiniQuery::Result::ErrorParser.new()
        @summary, @search, @agg = @parser.parse(@es_response_text)

        @type = @parser.type
        @reason = @parser.reason

        return @summary, @search, @agg, self
      end
    end
  end
end
