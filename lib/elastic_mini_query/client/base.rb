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

    def debug!
      @debug = true
    end

    def request
      b = ElasticMiniQuery::Query::Builder.new
      b.size = size
      b.track_total_hits = track_total_hits
      yield b

      res = http_post do |req|
        url = "/#{b.indices}/_search"
        body = b.to_json
        req.url(url)
        req.body = body

        if @debug
          puts url
          puts body
        end
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
