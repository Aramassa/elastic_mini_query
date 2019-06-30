class RealClient < ElasticMiniQuery::Client::Base
  elastic_mini_host ENV['ELASTIC_URL'] || "http://localhost:9200"
  elastic_mini_api_key ENV['API_KEY']

  def get_all_docs
    request do |builder|
      builder.indices = "bank"
    end
  end

  def search(word, col=nil)
    request do |builder|
      builder.indices = "bank"
      builder.query.match(word, col)
    end
  end

  def search_phrase(word, col=nil)
    request do |builder|
      builder.indices = "bank"
      builder.query.match(word, col).match_phrase
    end
  end

  def search_by_address(word)
    request do |builder|
      builder.indices = "bank"
      builder.query.match(word, :address)
    end
  end

  def test_agg
    request do |builder|
      builder.agg(:date_histgram, "by_date")
          .agg("USDJPY_avg", "USDJPY_min", [:avg])
    end
  end
end
