require 'rails_helper'

RSpec.describe "Post_new", type: :request do
  describe "get posts/new" do
    let(:user) { create(:user, :with_icon_image) }
    let(:met_object) { create(:met_object) }

    describe "リクエストの確認" do

      context "ログインしない場合" do
        before do
          get new_post_path(met_object_id: met_object.id)
        end

        it "新規投稿画面にアクセスできない" do
          expect(response).to have_http_status(302)
        end
      end
      
      context "ログインした場合" do
        before do
          sign_in user
          get new_post_path(met_object_id: met_object.id)
        end

        it "リクエストが成功する" do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe "投稿フォーム" do
      before do
        sign_in user
        get new_post_path(met_object_id: met_object.id)
        @post = assigns(:post) # newアクション用の@postインスタンス
      end
      
      it "作品画像URLが含まれる" do
          expect(response.body).to include(@post.met_object.primary_image_small)
      end

      it "タイトルが含まれる" do
        expect(response.body).to include(@post.met_object.title)
      end

      it "制作者が含まれる" do
        expect(response.body).to include(@post.met_object.artist_display_name)
      end

      it "制作年が含まれる" do
        expect(response.body).to include(@post.met_object.object_date)
      end

      it "ジャンルが含まれる" do
        expect(response.body).to include(ja_translated_name(@post.met_object.department))
      end

      it "投稿者画像が含まれる" do
        expect(user.image).to be_attached
      end

      it "投稿者名が含まれる" do
        expect(response.body).to include(user.name)
      end

      it "コメント欄が含まれる" do
        expect(response.body).to include("コメントを入力")
      end
      
      it "投稿ボタンが含まれる" do
        expect(response.body).to include("投稿")
        expect(response.body).to include('class="btn btn-outline-secondary"')
      end

      it "キャンセルボタンが含まれる" do
        expect(response.body).to include("キャンセル")
        expect(response.body).to include('class="btn btn-outline-secondary"')
      end
    end

    describe "投稿動作の確認" do
      context "ログインしない場合" do

        it "投稿ができない" do
          expect{
            # posts_controllerのparamsの内容に値を入れて渡す
            post posts_path, params: {
              post: {
                comment: "submit_test",
                met_object_id: met_object.id
              }
            }
          }.not_to change(Post, :count)
        end
      end
      
      context "ログインした場合" do
        before do
          sign_in user
        end

        it "投稿が成功する" do
          expect{
            post posts_path, params: {
              post: {
                comment: "submit_test",
                met_object_id: met_object.id
              }
            }
          }.to change(Post, :count).by(1)
        end

        it "投稿が失敗すると元の画面に戻る" do # ここでは render "new"
          expect{
            post posts_path, params: {
              post: {
                comment: "",
                met_object_id: met_object.id
              }
            }
          }.not_to change(Post, :count)
          expect(response).to have_http_status(:success) 
        end
      end
    end
  end
end
