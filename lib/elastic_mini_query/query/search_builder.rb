module ElasticMiniQuery
  module Query
    class SearchBuilder
      def initialize
        @match
        @multi_match
      end

      def match(word, col = nil)
        if col.nil?
          @multi_match = {query: word}
        else
          @match = {}
          @match[col] = word
        end

      end

      def to_json
        query = {}
        query[:match] = @match if @match
        query[:multi_match] = @multi_match if @multi_match

        query
      end
    end
  end
end
