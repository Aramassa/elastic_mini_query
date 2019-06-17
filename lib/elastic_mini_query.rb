require "elastic_mini_query/version"
require "elastic_mini_query/http_methods"

module ElasticMiniQuery
  class Client
    include ElasticMiniQuery::HttpMethods
  end
  

  class Error < StandardError; end
  # Your code goes here...
end
