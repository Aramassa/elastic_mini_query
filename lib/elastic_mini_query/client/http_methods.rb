require "faraday"

module ElasticMiniQuery::Client
  module HttpMethods
    module ClassMethods
      def elastic_mini_host(host=nil)
        @host = host unless host.nil?
        @host
      end

      def elastic_mini_api_key(key=nil)
        @key = key unless key.nil?
        @key
      end

      def faraday_client
        Faraday.new(url: elastic_mini_host) do |conn|
          conn.adapter :net_http
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def http_post
      res = self.class.faraday_client.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "ApiKey #{self.class.elastic_mini_api_key}"
  
        yield req
      end
    end
  end
end
