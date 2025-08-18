require 'rails_helper'

RSpec.describe "Post_contents", type: :request do
  describe "GET /top" do # 投稿内容の確認をトップページで行う
    let (:user) { create(:user, :with_icon_image) }
    let!(:post) { create(:post, user: user) }
    let (:other_user) { create(:user, name: "other", email: "other@com") }

    describe "共通の投稿内容" do
      before do
        get root_path
      end

      describe "作品情報" do
        it "作品画像URLが含まれる" do
          expect(response.body).to include(post.met_object.primary_image_small)
        end
        it "タイトルが含まれる" do
          expect(response.body).to include(post.met_object.title)
        end
        it "制作者が含まれる" do
          expect(response.body).to include(post.met_object.artist_display_name)
        end
        it "制作年が含まれる" do
          expect(response.body).to include(post.met_object.object_date)
        end
        it "ジャンルが含まれる" do
          expect(response.body).to include(ja_translated_name(post.met_object.department))
        end
      end

      describe "投稿者情報" do
        it "投稿者画像が含まれる" do
          expect(post.user.image).to be_attached
        end
        it "投稿者名が含まれる" do
          expect(response.body).to include(post.user.name)
        end
        it "コメントが含まれる" do
          expect(response.body).to include(post.comment)
        end
      end

      describe "ボタン情報" do
        it "いいねボタンが含まれる" do
          expect(response.body).to include('class="bi bi-balloon-heart"')
        end
      end
    end
    
    describe "個別の内容" do
      context "ログインしない場合" do
        before do
          get root_path
        end

        it "投稿に編集と削除ボタンが含まれない" do
          expect(response.body).not_to include("編集")
          expect(response.body).not_to include("削除")
        end

        it "投稿を削除できない" do
          # 削除は表示されないが、リクエストが仮に飛んだ時の確認は行う
          expect {delete post_path(post)}.not_to change(Post, :count)
        end
      end

      context "ログインする場合(current_user == post.user)" do
        before do
          sign_in user
          get root_path
        end

        it "その投稿に編集と削除ボタンが含まれる" do
          expect(response.body).to include("編集")
          expect(response.body).to include("削除")
        end

        it "その投稿を削除できる" do
          expect {delete post_path(post)}.to change(Post, :count).by(-1)
        end
      end

      context "ログインする場合(current_user != post.user)" do
        before do
          sign_in other_user
          get root_path
        end

        it "その投稿に編集と削除ボタンが含まれない" do
          expect(response.body).not_to include("編集")
          expect(response.body).not_to include("削除")
        end

        it "その投稿を削除できない" do
          expect {delete post_path(post)}.not_to change(Post, :count)
        end
      end
    end
  end
end
