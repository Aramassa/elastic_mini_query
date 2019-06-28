require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    include ::ElasticMiniQuery::Client::HttpMethods

    class << self
      def elastic_mini_es_version(version)
        @version = version
      end
    end

    attr_accessor :size, :track_total_hits

    def initialize
      @size = 100
      @track_total_hits = true
    end

    def request
      b = ElasticMiniQuery::Query::Builder.new
      b.size = size
      b.track_total_hits = track_total_hits
      yield b

      res = http_post do |req|
        req.url("/#{b.indices}/_search")
        req.body = b.to_json
      end

      ElasticMiniQuery::Query::Response.new(ElasticMiniQuery::Result::Raw.new(res.body))
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
