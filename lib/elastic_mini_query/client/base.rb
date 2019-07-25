require_relative "http_methods"
require_relative "request_dialect_v00"
require_relative "request_dialect_v68"

module ElasticMiniQuery::Client
  class Base
    attr_accessor :size, :track_total_hits

    class << self
      def elastic_mini_es_version(version)
        @version = Gem::Version.create(version)
      end

      def elastic_mini_host(host=nil)
        @host = host unless host.nil?
        @host
      end

      def elastic_mini_api_key(key=nil)
        @key = key unless key.nil?
        @key
      end

      def request_dialector
        case
          when @version < Gem::Version.create("7.0")
            RequestDialectV68.new
          else
            RequestDialectV00.new
        end
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

    def poster(indice, type)
      ElasticMiniQuery::Client::Base::IndicePoster.new(self.class.request_dialector, self.class.elastic_mini_host, self.class.elastic_mini_api_key, indice, type)
    end

    class IndicePoster
      include ::ElasticMiniQuery::Client::HttpMethods

      def initialize(dialector, url, key, indice, type)
        @dialector = dialector
        @client = self.class.faraday_client(url)
        @indice = indice
        @type = type
        @key = key
      end

      def empty_index!
        @client.put do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "ApiKey #{@key}"

          url = "/#{@indice}"
          req.url(url)
          req.body = {}.to_json
        end
      end

      def delete_index!
        @client.delete do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "ApiKey #{@key}"

          url = "/#{@indice}"
          req.url(url)
          req.body = {}.to_json
        end
      end

      def template!(name, patterns, properties, order: nil)
        @client.put do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "ApiKey #{@key}"

          url = "/_template/#{name}"
          body = {
            "index_patterns": patterns,
            "mappings": {
              "properties": properties
            }
          }
          body[:order] = order if order
          req.url(url)
          req.body = body.to_json
        end
      end

      def post!(id, doc)
        @client.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "ApiKey #{@key}"

          url = "/#{@indice}/#{@type}/#{id}"
          url = @dialector.indice_url(@indice, @type, id)
          body = doc.to_json
          req.url(url)
          req.body = body
        end
      end

      def mapping!(mapping)
        res = @client.put do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "ApiKey #{@key}"

          url = @dialector.mapping_url(@indice, @type)
          body = mapping.to_json
          req.url(url)
          req.body = body
        end

        raise ElasticMiniQuery::ResponseError.new(res) unless res.status == 200

        return res
      end

      def mapping(mapping)
        begin
          return mapping!(mapping)
        rescue => e
          return ElasticMiniQuery::Query::Response.new(ElasticMiniQuery::Result::Error.new(e.response.body, nil))
        end
      end
    end

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
