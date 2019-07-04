require_relative "http_methods"

module ElasticMiniQuery::Client
  class Base
    attr_accessor :size, :track_total_hits

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

    def initialize
      @size = 100
      @track_total_hits = true
    end

    def debug!
      @debug = true
      self
    end

    def execute
      Requester.new(@b, self.class.elastic_mini_host, self.class.elastic_mini_api_key).execute(@debug)
    end

    def execute!
      Requester.new(@b, self.class.elastic_mini_host, self.class.elastic_mini_api_key).execute!(@debug)
    end

    def build
      @b ||= ElasticMiniQuery::Query::Builder.new
      @b.size = size
      @b.track_total_hits = track_total_hits
      yield @b

      self
    end
    private :build

    class Requester
      include ::ElasticMiniQuery::Client::HttpMethods

      def initialize(builder, url, key)
        @builder = builder
        @url = url
        @key = key
      end

      def execute!(debug)
        res = http_post(@url, @key) do |req|
          url = "/#{@builder.indices}/_search"
          body = @builder.to_json
          req.url(url)
          req.body = body

          if debug
            puts url
            puts body
          end
        end

        unless res.status == 200
          raise ElasticMiniQuery::ResponseError.new(res)
        end

        ElasticMiniQuery::Query::Response.new(ElasticMiniQuery::Result::Raw.new(res.body, @builder.parser_keys))
      end

      def execute(debug)
        begin
          return execute!(debug)
        rescue ElasticMiniQuery::ResponseError => e
          return ElasticMiniQuery::Query::Response.new(ElasticMiniQuery::Result::Error.new(e.response.body, nil))
        end
      end
    end
  end
end
