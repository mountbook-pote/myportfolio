require 'rails_helper'

RSpec.describe "Post_index", type: :request do
  describe "get /posts" do
    let(:user) { create(:user, name: "tarou") }
    let(:other_user) { create(:user, name: "zirou") }
    let!(:post_european) { create(:post, user: user, met_object: create(:met_object, department: "European Paintings")) }
    let!(:post_medieval) { create(:post, met_object: create(:met_object, department: "Medieval Art")) }
    let!(:post_egyptian) { create(:post, met_object: create(:met_object, department: "Egyptian Art")) }
    let!(:other_post_european) do
      create(:post, user: other_user, met_object: create(:met_object, department: "European Paintings"))
    end

    context "投稿一覧にアクセスした時" do
      before do
        get posts_index_path
      end

      it "リクエストが成功する" do
        expect(response).to have_http_status(:success)
      end

      it "検索キーワード欄が含まれる" do
        expect(response.body).to include('class="keyword-area input"')
      end

      it "ジャンルのチェックボックスが全て含まれる" do
        expect(
          response.body.scan('class="checkbox-color"').count
        ).to eq(3)
      end

      it "検索ボタンが含まれる" do
        expect(response.body).to include('class="btn btn-primary search-space__search-box"')
      end

      it "全ての投稿件数が含まれる" do
        expect(response.body).to include("全ての投稿：#{Post.all.count}件")
      end

      it "全ての投稿が含まれる" do
        Post.all.each do |post|
          expect(response.body).to include(post.comment)
        end
      end
    end

    context "全てのチェックを外して検索した時" do
      before do
        # 検索はそのpathにparamsを渡す
        get posts_index_path, params: { q: { met_object_department_in: "" } }
      end
      it "検索結果：0件が含まれる" do
        expect(response.body).to include("検索結果：0件")
      end

      it "「検索結果はありません」が含まれる" do
        expect(response.body).to include("検索結果はありません")
      end
    end

    context "ジャンルを１つ指定して検索した時" do
      before do
        get posts_index_path, params: { q: { met_object_department_in: ["European Paintings"] } }
      end

      it "指定したジャンルの投稿が全て含まれる" do
        expect(response.body).to include(post_european.comment)
        expect(response.body).to include(other_post_european.comment)
      end

      it "指定外のジャンルの投稿が含まれない" do
        expect(response.body).not_to include(post_medieval.comment)
        expect(response.body).not_to include(post_egyptian.comment)
      end
    end

    context "ジャンルと投稿者を指定して検索した時" do
      before do
        get posts_index_path, params: {
          q: { met_object_department_in: ["European Paintings"], user_name_cont: "tarou" },
        }
      end

      it "指定したジャンルと投稿者の投稿が含まれる" do
        expect(response.body).to include(post_european.comment)
      end

      it "指定したジャンルだが、投稿者が異なる投稿が含まれない" do
        expect(response.body).not_to include(other_post_european.comment)
      end
    end
  end
end
