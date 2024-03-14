RSpec.describe "Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    let(:user) { create(:user) }
    let(:valid_params) { { email: user.email, password: user.password } }
    let(:invalid_params) { { email: user.email, password: "invalid_password" } }

    context "有効なパラメーターが渡されたとき" do
      it "ログインできる" do
        post "/api/v1/auth/sign_in", params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "無効なパラメーターが渡されたとき" do
      it "ログインに失敗する" do
        post "/api/v1/auth/sign_in", params: invalid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
