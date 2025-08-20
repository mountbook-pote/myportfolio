require 'rails_helper'

RSpec.describe "Post_edit", type: :request do
  describe "get posts/id/edit" do
    let(:user) { create(:user, :with_icon_image) }
    let!(:post) { create(:post, user: user) }
    let(:other_user) { create(:user, name: "other", email: "other@com") }

    describe "リクエストの確認" do
      context "ログインしない場合" do
        it "投稿編集画面にアクセスできない" do
          get edit_post_path(post)
          expect(response).to have_http_status(302)
        end
      end

      context "ログインした場合(current_user == post.user)" do
        before do
          sign_in user
        end

        it "リクエストが成功する" do
          get edit_post_path(post)
          expect(response).to have_http_status(:success)
        end
      end

      context "ログインした場合(current_user != post.user)" do
        before do
          sign_in other_user
        end

        it "他ユーザの投稿編集画面にアクセスできない" do
          get edit_post_path(post)
          expect(response).to have_http_status(302)
        end
      end
    end

    describe "投稿フォーム" do
      before do
        sign_in user
        get edit_post_path(post)
      end

      it "投稿フォームの内容が含まれる" do # 内容はnew_spec.rbと共通のパーシャルを使用
        expect(response.body).to include(post.comment)
      end
    end

    describe "動作の確認" do
      context "ログインしない場合" do
        it "投稿の更新ができない" do
          expect  do
            patch post_path(post), params: { # updateはアクション名で、httpメソッドではpatchを使う
              post: {
                comment: "update_test",
              },
            }
          end.not_to change(Post, :count)
          expect(post.reload.comment).to eq post.comment
        end
      end

      context "ログインした場合(current_user == post.user)" do
        before do
          sign_in user
          get edit_post_path(post)
        end

        it "投稿の更新が成功する" do
          expect  do
            patch post_path(post), params: {
              post: {
                comment: "update_test",
              },
            }
          end.not_to change(Post, :count)
          expect(post.reload.comment).to eq "update_test"
        end

        it "投稿の更新が失敗すると元の画面に戻る" do # ここではrender "edit"
          expect  do
            patch post_path(post), params: {
              post: {
                comment: "",
              },
            }
          end.not_to change(Post, :count)
          expect(post.reload.comment).to eq post.comment
          expect(response).to have_http_status(:success)
        end
      end

      context "ログインした場合(current_user != post.user)" do
        before do
          sign_in other_user
        end

        it "投稿の更新ができない" do
          expect  do
            patch post_path(post), params: {
              post: {
                comment: "update_test",
              },
            }
          end.not_to change(Post, :count)
          expect(post.reload.comment).to eq post.comment
        end
      end
    end
  end
end
