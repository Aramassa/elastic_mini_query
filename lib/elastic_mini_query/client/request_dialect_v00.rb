module ElasticMiniQuery
  module Client
    class RequestDialectV00

      def indice_url(indice, type, id)
        "/#{indice}/_doc/#{id}"
      end

      def mapping_url(indice, type)
        "/#{indice}/_mapping"
      end
    end
  end
end