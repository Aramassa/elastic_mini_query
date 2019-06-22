require "json"

module ElasticMiniQuery
  module Result
    class RawParser
      def initialize(version: :latest)
        @dialector = ElasticMiniQuery::Result::RawDialectBase.dialector(version)
      end

      def parse(response)
        @json = JSON.parse(response)

        summary = ElasticMiniQuery::Result::Summary.new
        search  = ElasticMiniQuery::Result::SearchResult.new
        agg     = ElasticMiniQuery::Result::AggResult.new

        summary.took = took
        summary.total_hits = total_hits
        summary.timed_out = timed_out

        return [summary, search, agg]
      end

      def took
        @json["took"].to_i
      end

      def timed_out
        @json["timed_out"]
      end

      def total_hits
        @json["hits"]["total"]["value"].to_i
      end


    end
  end
end
