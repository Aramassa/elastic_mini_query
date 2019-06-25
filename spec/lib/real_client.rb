class RealClient < ElasticMiniQuery::Client::Base
  elastic_mini_host = ENV['ELASTIC_URL']
  elastic_mini_api_key = ENV['API_KEY']

  class << self
    def test
      request do |builder|
        builder.agg(:date_histgram, "by_date")
          .agg("USDJPY_avg", "USDJPY_min", [:avg])
      end
    end
  end
end
