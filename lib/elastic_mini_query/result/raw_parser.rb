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
        summary.took = took
        summary.total_hits = total_hits
        summary.timed_out = timed_out
        summary.total_hits_relation = total_hits_relation

        search = ElasticMiniQuery::Result::SearchResult.new
        search.hits = hits
        search.sources = sources

        agg = ElasticMiniQuery::Result::AggResult.new(aggregations)

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

      def total_hits_relation
        @json["hits"]["total"]["relation"]
      end

      def hits
        @json["hits"]["hits"]
      end

      def sources
        @json["hits"]["hits"].map {|d| d["_source"]}
      end

      def aggregations
        @json["aggregations"]
      end
    end
  end
end
