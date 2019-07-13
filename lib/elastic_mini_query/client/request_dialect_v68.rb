module ElasticMiniQuery
  module Client
    class RequestDialectV68 < RequestDialectV00
      def mapping_url(indice, type)
        "/#{indice}/_mapping/#{type}"
      end
    end
  end
end