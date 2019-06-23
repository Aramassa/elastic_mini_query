module ElasticMiniQuery::Result
  class AggItem
    attr_reader :key, :key_as_string, :doc_count

    def initialize(item_hash)
      i = item_hash.dup
      @key = i.delete("key")
      @key_as_string = i.delete("key_as_string")
      @doc_count = i.delete("doc_count")

      @fields = i
    end

    def [](key)
      @fields[key]["value"]
    end
  end
end
