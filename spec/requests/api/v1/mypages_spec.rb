# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Mypages", type: :request do
  describe "GET /api/v1/mypages" do
    context "ユーザーがログインしているとき" do
      10.times do
        before do
          create(:article, post_status: :published, user_id: current_user_id)
        end
      end
      before { create_list(:article, 10, user_id: current_user_id) }

      let!(:other_user) { create(:user) }
      let!(:other_user_id) { other_user.id }
      let!(:current_user) { create(:user) }
      let!(:current_user_id) { current_user.id }

      it "自分が投稿した、下書きを含む全ての記事のレコードが取得できること" do
        get(
          api_v1_my_articles_path,
          headers: authentication_headers_for(current_user),
        )
        res = JSON.parse(response.body)
        expect(res["data"]).to be_all {|data| data["attributes"]["user_id"] === current_user_id }
        expect(response).to have_http_status(:ok)
      end

      it "下書き記事は他のユーザーから見えないこと" do
        get(
          api_v1_my_articles_path,
          headers: authentication_headers_for(other_user),
        )
        res = JSON.parse(response.body)
        expect(res["data"].length).to eq(0)
        expect(response.status).to eq(200)
      end
    end
  end
end
