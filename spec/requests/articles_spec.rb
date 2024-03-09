require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject { get api_v1_articles_path }

    before { FactoryBot.create_list(:article, 3) }

    it "全ての記事が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
    end

    it "全てのキーが取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
    end

    it "ステータスコードが正常" do
      subject
      JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    let(:article) { create(:article) }
    let(:article_id) { article.id }

    context "指定したidの記事が存在するとき" do
      it "その記事のレコードが取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res).to include(
          "title" => article.title,
          "body" => article.body,
          "updated_at" => article.updated_at.utc.iso8601(3),
          "id" => article_id,
        )
      end
    end

    context "指定したidの記事が存在する" do
      it "ステータスコードが正常" do
        subject
        JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの記事が存在したいとき" do
      let(:article_id) { 100000 }
      it "その記事のレコードが取得できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
