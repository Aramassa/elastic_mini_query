require "faraday"

module ElasticMiniQuery::Client
  module HttpMethods
    module ClassMethods
      def faraday_client(url, headders: {})
        headders['Content-Type'] = 'application/json'
        Faraday.new(url: url, headers: headders) do |conn|
          conn.adapter :net_http
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def http_post(url, key)
      res = self.class.faraday_client(url).post do |req|
        req.headers['Authorization'] = "ApiKey #{key}"
  
        yield req
      end
    end
  end
end
