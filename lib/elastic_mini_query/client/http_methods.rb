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
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def faraday_client
      Faraday.new(url: self.class.elasticsearch_url) do |conn|
        conn.adapter :net_http
      end
    end
    private :faraday_client

    def http_post
      res = faraday_client.post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "ApiKey #{API_KEY}"

        yield req
      end
    end
  end
end
