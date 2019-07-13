module ElasticMiniQuery
  module Client
    class RequestDialectV00

      def mapping_url(indice, type)
        "/#{indice}/_mapping"
      end
    end
  end
end