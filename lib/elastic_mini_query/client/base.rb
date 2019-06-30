require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    class << self
      def elastic_mini_es_version(version)
        @version = version
      end

      def elastic_mini_host(host=nil)
        @host = host unless host.nil?
        @host
      end

      def elastic_mini_api_key(key=nil)
        @key = key unless key.nil?
        @key
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

    def build
      b = ElasticMiniQuery::Query::Builder.new
      b.size = size
      b.track_total_hits = track_total_hits
      yield b

      Requester.new(b, self.class.elastic_mini_host, self.class.elastic_mini_api_key)
    end
    private :build

    def agg(type, name)
      agg(type, name)
    end

    class Requester
      include ::ElasticMiniQuery::Client::HttpMethods

      def initialize(builder, url, key)
        @builder = builder
        @url = url
        @key = key
      end

      def execute
        res = http_post(@url, @key) do |req|
          url = "/#{@builder.indices}/_search"
          body = @builder.to_json
          req.url(url)
          req.body = body

          if @debug
            puts url
            puts body
          end
        end

        ElasticMiniQuery::Query::Response.new(ElasticMiniQuery::Result::Raw.new(res.body))
      end
    end
  end
end
