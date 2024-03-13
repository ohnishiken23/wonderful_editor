require "rails_helper"

RSpec.describe "Api/V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    let(:params) { attributes_for(:user) }

    context "必要なパラメーターが存在するとき" do
      it "ユーザーのレコードが作成できる" do
        post "/api/v1/auth", params: { registration: params }
        res = JSON.parse(response.body)
        header = response.header
        expect(res["data"]["name"]).to eq params[:name]
        expect(res["data"]["email"]).to eq params[:email]
        expect(response).to have_http_status(:ok)
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end

    context "ユーザー名が存在しないとき" do
      it "ユーザーのレコードが作成できない" do
        post "/api/v1/auth", params: { registration: { name: "", email: "test@example.com", password: "password", password_confirmation: "password" } }
        res = JSON.parse(response.body)
        expect(res["errors"]["name"]).to include("can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "emailが存在しないとき" do
      it "ユーザーのレコードが作成できない" do
        post "/api/v1/auth", params: { registration: { name: "test", email: "", password: "password", password_confirmation: "password" } }
        res = JSON.parse(response.body)
        expect(res["errors"]["email"]).to include("can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
