require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    include ::ElasticMiniQuery::Client::HttpMethods

    class << self
      def elastic_mini_es_version(version)
        @version = version
      end
    end
  end
end
