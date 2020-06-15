module ElasticMiniQuery
  module Result
    class Summary

      POSSIBLE_KEYS = [:took, :timed_out, :total_hits, :total_hits_relation]
      attr_accessor(*POSSIBLE_KEYS)

      def possible_keys
        POSSIBLE_KEYS
      end
    end
  end
end
