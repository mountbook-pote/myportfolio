require 'rails_helper'

RSpec.describe "top_page", type: :request do
  describe "GET /top" do
    before do
      get root_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end

    context "投稿がある場合(新着投稿の最大表示件数+1件とする)" do
      let(:user) { create(:user) }
      let!(:posts) { create_list(:post, 7, user: user) }
      # controllerで順番を新着順にするため、順番を並び替える
      let(:reversed_posts) { posts.sort_by(&:created_at).reverse }
      before do
        get root_path
      end

      it "新着投稿欄に投稿が6件含まれる" do
        expect(
          reversed_posts.take(6).all? { |post| response.body.include?(post.comment)}
        ).to be true
      end

      it "新着投稿欄に7件目の投稿が含まれない" do
          expect(response.body).not_to include(reversed_posts[6].comment)
      end
    end
    context "投稿がない場合" do
      before do
        get root_path
      end

      it "「新着投稿はありません」が含まれる" do
        expect(response.body).to include("新着投稿はありません")
      end
    end
  end
end
