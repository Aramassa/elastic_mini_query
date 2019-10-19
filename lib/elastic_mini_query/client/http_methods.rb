require "faraday"

module ElasticMiniQuery::Client
  module HttpMethods
    module ClassMethods
      def faraday_client(url)
        Faraday.new(url: url) do |conn|
          conn.adapter :net_http
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def http_post(url, key)
      res = self.class.faraday_client(url).post do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "ApiKey #{key}"
  
        yield req
      end
    end
  end
end
