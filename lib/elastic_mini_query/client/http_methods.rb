module ElasticMiniQuery::Client
  module HttpMethods
    module ClassMethods
      def elastic_mini_host(host)
        @host = host
      end

      def host
        @host
      end

      def elastic_mini_api_key(key)
        @key = key
      end

      def api_key
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
