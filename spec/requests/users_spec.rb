require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { get api_v1_users_path }
    before {FactoryBot.create_list(:user, 5)}

    it "ユーザーの一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 5
      expect(res[0].keys).to eq ["id", "provider", "uid", "allow_password_change", "name", "image", "email", "created_at", "updated_at"]
      expect(response).to have_http_status(200)
    end
  end
end
