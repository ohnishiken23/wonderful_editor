require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    subject {get api_v1_articles_path}
    before do
      # 5人のユーザーを作成する
      users = FactoryBot.create_list(:user, 5)

      # 各ユーザーに対して3つずつの記事を作成する
      users.each do |user|
        3.times do
          FactoryBot.create(:article, user: user)
        end
      end
    end
    fit "記事の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 15
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(response).to have_http_status(200)
    end
  end
end
