module ElasticMiniQuery
  module Result
    class Raw
      def initialize(es_response_text, parser_keys)
        @es_response_text = es_response_text
        @parser_keys = parser_keys
      end

      def parse
        return @summary, @search, @agg unless @parse_result.nil?
        @parser = ElasticMiniQuery::Result::RawParser.new()
        @summary, @search, @agg = @parser.parse(@es_response_text, @parser_keys)
      end
    end
  end
end
