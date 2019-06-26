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

        res = http_post do |req|
          req.url("/#{b.indice}/_search")
          req.body = b.to_json
        end

        JSON.parse(res.body)
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
