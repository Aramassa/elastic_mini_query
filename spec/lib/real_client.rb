class RealClient < ElasticMiniQuery::Client::Base
  elastic_mini_host ENV['ELASTIC_URL']
  elastic_mini_api_key ENV['API_KEY']

  def get_all_docs
    request do |builder|
      builder.indices = "bank"
    end
  end

  def search(word)
    request do |builder|
      builder.indices = "bank"
      builder.query.match(word)
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
