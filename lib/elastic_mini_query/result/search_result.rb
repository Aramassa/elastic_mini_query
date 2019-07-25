require "elastic_mini_query/result/search_doc"

module ElasticMiniQuery::Result
  class SearchResult
    attr_accessor :hits, :sources
  end
end
