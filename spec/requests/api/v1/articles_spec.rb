require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    context "公開中の記事があるとき" do
      10.times do
        before do
          create(:article, post_status: :published)
        end
      end

      it "記事一覧が取得できること" do
        subject
        res = JSON.parse(response.body)

        expect(res["data"].length).to eq(10)
        expect(res["data"][0]["attributes"].keys).to include("title", "body", "user_id", "post_status")
        expect(response.status).to eq(200)
      end
    end

    context "記事がすべて非公開のとき" do
      before { create_list(:article, 10) }

      it "空配列が返ること" do
        subject
        res = JSON.parse(response.body)
        expect(res["data"].length).to eq(0)
        expect(response.status).to eq(200)
      end
    end
  end

end
