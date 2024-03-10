require "rails_helper"

RSpec.describe "Articles", type: :request do
  before { create_list(:article, 3) }

  describe "GET /articles" do
    subject { get api_v1_articles_path }

    it "全ての記事が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
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
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to eq article.updated_at.utc.iso8601(3)
        expect(res["id"]).to eq article.id
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの記事が存在しないとき" do
      let(:article_id) { 100000 }
      it "その記事のレコードが取得できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /articles" do
    subject { post(api_v1_articles_path, params: params) }

    let(:params) { { article: attributes_for(:article) } }
    context "適切なパラメーターを送信したとき" do
      it "記事のレコードを作成できる" do
        expect { subject }.to change { Article.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(response).to have_http_status(:created)
      end
    end
  end
end
