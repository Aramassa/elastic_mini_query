module ElasticMiniQuery
  module Query
    class SearchBuilder
      def initialize
        @match
        @multi_match
        @any_word = true
        @phrase_match = false

        @date_range = nil
      end

      ##
      # @param field [String]
      # @param str [String]
      #   ex: "now-120d/d"
      def date_range(field, term_gte: nil, term_lte: nil)
        @date_range = {}
        @date_range["#{field}"] = {}

        @date_range["#{field}"][:gte] = term_gte if term_gte
        @date_range["#{field}"][:lte] = term_lte if term_lte
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

        query[:range] = @date_range if @date_range
        query
      end
    end
  end
end
