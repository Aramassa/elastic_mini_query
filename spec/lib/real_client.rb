class RealClient < ElasticMiniQuery::Client::Base
  elastic_mini_host ENV['ELASTIC_URL'] || "http://localhost:9200"
  elastic_mini_api_key ENV['API_KEY']

  def get_all_docs
    build do |builder|
      builder.indices = "bank"
    end
  end

  def search(word, col=nil)
    build do |builder|
      builder.indices = "bank"
      builder.query.match(word, col)
    end
  end

  def search_phrase(word, col=nil)
    build do |builder|
      builder.indices = "bank"
      builder.query.match(word, col).match_phrase
    end
  end

  def search_by_address(word)
    build do |builder|
      builder.indices = "bank"
      builder.query.match(word, :address)
    end
  end

  def empty_index
    build do |builder|
      builder.indices = "not-exists"
    end
  end

  def agg_balance
    build do |builder|
      builder.indices= "bank"
      builder.aggs.agg(:balance, [:min, :max])
    end

  end

  def agg_by_date(order: :desc, interval: :day)
    build do |builder|
      builder.indices= "logstash-*"
      builder.aggs.agg(:memory, [:min, :max, :avg]).date_histgram("@timestamp", interval, order: order)
    end
  end
end
