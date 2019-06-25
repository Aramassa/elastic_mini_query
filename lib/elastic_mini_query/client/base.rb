require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    include ::ElasticMiniQuery::Client::HttpMethods

    class << self
      def elastic_mini_es_version(version)
        @version = version
      end

      def request
        b = ElasticMiniQuery::Query::Builder.new
        yield b

        ## TODO faraday request
        b
      end
      private :request

      def build
        b = ElasticMiniQuery::Query::Builder.new
        yield b
        b
      end
      private :build

      def agg(type, name)
        agg(type, name)
      end
    end

  end
end
