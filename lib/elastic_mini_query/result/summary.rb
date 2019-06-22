module ElasticMiniQuery
  module Result
    class Summary

      attr_accessor :took, :timed_out, :total_hits, :total_hits_relation
    end
  end
end
