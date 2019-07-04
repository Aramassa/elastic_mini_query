require "elastic_mini_query/version"
require "elastic_mini_query/client/base"
require "elastic_mini_query/query/response"
require "elastic_mini_query/query/builder"
require "elastic_mini_query/result/error"
require "elastic_mini_query/result/error_parser"
require "elastic_mini_query/result/raw"
require "elastic_mini_query/result/raw_parser"
require "elastic_mini_query/result/raw_dialect_base"
require "elastic_mini_query/result/summary"
require "elastic_mini_query/result/search_result"
require "elastic_mini_query/result/agg_result"


module ElasticMiniQuery
  class Error < StandardError; end
  class ResponseError < StandardError
    attr_reader :response, :error
    def initialize(response)
      @response = response
      @error = ElasticMiniQuery::Result::Error.new(response.body, nil)
    end
  end
end
