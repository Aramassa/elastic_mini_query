require "date"
require "bundler/setup"
require "elastic_mini_query"

require "lib/real_client"

RSpec.describe "Searcy Queries" do

  ##
  # @return RealClient
  let!(:client) {
    RealClient.new
  }

  context "get all data" do
    it "get all data" do
      res = client.get_all_docs.sort_by(_id: :asc).execute

      s = res.summary
      r = res.search

      expect(s.total_hits).to eq(500)
      expect(client.size).to eq(100)

      doc = r.sources.first
      expect(doc["name"]).to eq("name1000 test1000")
      expect(doc["age"]).to eq(15)
    end
  end

  context "String search" do

    it "search all field" do
      res = client.search("Are you OK?").execute
      s   = res.summary

      expect(s.total_hits).to eq(33)
    end

    it "search by bank address" do
      res = client.search_by_hobby("baseball").execute
      s   = res.summary

      expect(s.total_hits).to eq(360)

      res = client.search_by_hobby("piano").execute
      s   = res.summary

      expect(s.total_hits).to eq(28)

    end

    it "multiple columns specified" do
      res = client.search("bad", [:history, :introduction]).execute

      s = res.summary
      expect(s.total_hits).to eq(285)

      res = client.search("Good", [:history, :introduction]).execute

      s = res.summary
      expect(s.total_hits).to eq(156)
    end

    context "match phrase" do
      it "word search" do
        res = client.search("normal").execute
        s   = res.summary
        expect(s.total_hits).to eq(71)
      end

      it "match phrase" do
        res = client.search_phrase("Elastic").execute
        s   = res.summary
        expect(s.total_hits).to eq(368)

        res = client.search_phrase("football swim").execute
        s   = res.summary
        expect(s.total_hits).to eq(56)

        res = client.search_phrase("football").execute
        s   = res.summary
        expect(s.total_hits).to eq(84)
      end
    end
  end

  context "range search" do
    context "date" do
      it "@timestamp" do
        d1 = Time.utc(2015, 5, 18).to_date
        d2 = Time.now.to_date
        d_diff = (d2 - d1).to_i

        res = client.date_range("created_at", term_lte: "now", term_gte: "now-#{d_diff+10}d/d").execute
        s = res.summary
        r = res.search


        # r.sources.each do |row|
        #   p row
        # end
        expect(s.total_hits).to eq(500)

      end
    end
  end
end
