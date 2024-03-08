require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { get api_v1_users_path }

    before { FactoryBot.create_list(:user, 5) }

    it "全てのユーザーが取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 5
    end

    it "全てのキーが取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res[0].keys).to eq ["id", "name", "email"]
    end

    it "ステータスコードが正常" do
      subject
      JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
    end
  end
end
