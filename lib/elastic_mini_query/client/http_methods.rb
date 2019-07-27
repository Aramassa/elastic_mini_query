require "faraday"

module ElasticMiniQuery::Client
  module HttpMethods
    module ClassMethods
      def faraday_client(url, key: nil, headers: {})
        headers['Content-Type'] = 'application/json'
        headers['Authorization'] = "ApiKey #{key}" if key
        Faraday.new(url: url, headers: headers) do |conn|
          conn.adapter :net_http
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def http_post(url, key)
      res = self.class.faraday_client(url, key: key).post do |req|
        yield req
      end
    end
  end
end
