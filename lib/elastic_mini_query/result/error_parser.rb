require "json"

module ElasticMiniQuery
  module Result
    class ErrorParser
      attr_reader :type, :reason

      def initialize(version: :latest)
      end

      def parse(response)
        @json = JSON.parse(response)

        summary = ElasticMiniQuery::Result::Summary.new
        summary.took = 0
        summary.total_hits = 0
        summary.timed_out = false
        summary.total_hits_relation = "eq"

        search = ElasticMiniQuery::Result::SearchResult.new
        search.hits = []
        search.sources = []

        agg = ElasticMiniQuery::Result::AggResult.new(nil)

        @type = @json["error"]["type"]
        @reason = @json["error"]["reason"]

        return [summary, search, agg]
      end
    end
  end
end
