module ElasticMiniQuery
  module Query
    class SearchBuilder
      def initialize
        @match
        @multi_match
        @any_word = true
        @phrase_match = false
      end

      def match(word, col = nil)
        case
          when col.nil?
            @multi_match = {
              query: word,
              type: "most_fields"
            }
          when col.is_a?(Array)
            @multi_match = {
              query: word,
              type: "most_fields",
              fields: col
            }
          else
            @match      = {}
            @match[col] = word
        end

        self
      end

      def match_any(bool=true)
        @any_word = bool
        @phrase_match = !bool

        self
      end

      def match_phrase(bool=true)
        @phrase_match = bool
        @any_word = !bool

        self
      end

      def to_json
        @multi_match[:type] = "phrase" if @phrase_match && @multi_match
        query               = {}
        query[:match]       = @match if @match
        query[:multi_match] = @multi_match if @multi_match

        query
      end
    end
  end
end
