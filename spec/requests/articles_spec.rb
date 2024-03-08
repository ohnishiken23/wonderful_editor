require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject { get api_v1_articles_path }

    before do
      # 5人のユーザーを作成する
      users = FactoryBot.create_list(:user, 5)

      # 各ユーザーに対して3つずつの記事を作成する
      users.each do |user|
        FactoryBot.create_list(:article, 3, user: user)
      end
    end

    it "全ての記事が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 15
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
end
