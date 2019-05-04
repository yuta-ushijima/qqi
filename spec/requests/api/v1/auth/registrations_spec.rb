require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/sign_up" do
    subject { post(api_v1_user_registration_path, params: params) }
    context "ユーザーがメールアドレスとパスワードを入力した時" do
      let(:params) { attributes_for(:user) }
      it "ユーザー登録ができること" do
        subject
        res = JSON.parse(response.body)
        expect(res["status"]).to eq("success")
        expect(res["data"]["id"]).to eq(User.last.id)
        expect(res["data"]["name"]).to eq(User.last.name)
        expect(response).to have_http_status(:ok)
      end
    end
    context "リクエストパラメータが不正なとき" do
      let(:params) { { user: attributes_for(:user) } }
      it "ユーザー登録できないこと" do
        subject
        res = JSON.parse(response.body)
        expect(res["status"]).to eq("error")
        expect(res["errors"]).to include("Please submit proper sign up data in request body.")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }
    context "メールアドレスとパスワードが正しいとき" do
      let(:current_user) { create(:user) }
      let(:params) { { email: current_user.email,  password: current_user.password }}
      it "ユーザーがログインできること" do
        subject
        res = JSON.parse(response.body)
        expect(res["data"]["id"]).to eq(current_user.id)
        expect(res["data"]["email"]).to eq(current_user.email)
        expect(response.headers["uid"]).to be_present
        expect(response.headers["access-token"]).to be_present
        expect(response.headers["client"]).to be_present
        expect(response).to have_http_status(:ok)
      end
    end

    context "メールアドレスが正しくないとき" do
      let(:user) { create(:user) }
      let(:params) { { email: "invalid@example.com",  password: user.password }}
      it "ログインできないこと" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("Invalid login credentials. Please try again.")
        expect(res["success"]).to be_falsey
        expect(response.headers["uid"]).to be_blank
        expect(response.headers["access-token"]).to be_blank
        expect(response.headers["client"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "パスワードが正しくないとき" do
      let(:user) { create(:user) }
      let(:params) { { email: user.email,  password: "invalidpassword" }}
      it "ログインできないこと" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to include("Invalid login credentials. Please try again.")
        expect(res["success"]).to be_falsey
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/auth/sign_out" do
      context "ユーザーがログインしているとき" do
        let(:current_user) { create(:user) }
        let(:params) { { email: current_user.email,  password: current_user.password }}
        it "ログアウトできること" do
          post(api_v1_user_session_path, params: params)

          delete(destroy_api_v1_user_session_path, { headers: {
            uid: response.headers["uid"],
            client: response.headers["client"],
            "access-token": response.headers["access-token"]
          }})

          res = JSON.parse(response.body)
          expect(res["success"]).to be_truthy
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
