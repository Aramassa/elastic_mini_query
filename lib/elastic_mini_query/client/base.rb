require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    include ::ElasticMiniQuery::Client::HttpMethods
  end
end
