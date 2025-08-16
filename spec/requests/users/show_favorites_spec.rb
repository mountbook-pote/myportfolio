require 'rails_helper'

RSpec.describe "user_show_page", type: :request do
  describe "get/users/id" do
    let(:user) { create(:user, :with_icon_image) }
    let(:other_user) { create(:user, name: "other", email: "other@com") }
    let(:guest_user) { User.guest }

    describe "共通の内容" do
      before do
        get user_path(user)
      end

      it "リクエストが成功する" do
        expect(response).to have_http_status(:success)
      end

      describe "ユーザ情報" do
        let(:post) { create(:post, user: user) } 
        let!(:favorite) { create(:favorite, user: user, post: post) }
        before do
          get user_path(user)
        end

        it "ユーザ画像が含まれる" do
          expect(user.image).to be_attached
        end

        it "アカウント作成日が含まれる" do
          expect(response.body).to include(user.created_at.strftime("%Y/%m/%d"))
        end

        it "投稿数が含まれる" do
          expect(response.body).to include(user.posts.size.to_s)
        end

        it "いいねした数が含まれる" do
          expect(response.body).to include(user.favorite_posts.size.to_s)
        end

        it "いいねされた数が含まれる" do
          expect(response.body).to include(favorited_by_users_count(user).to_s)
        end
      end

      context "ユーザの投稿を表示時" do
        context "そのユーザの投稿がある場合" do
          let(:post) { create(:post, user: user) } 
          let!(:favorite) { create(:favorite, user: user, post: post) }
          let(:other_post) { create(:post, user: other_user, comment: "other_comment") } 
          let!(:other_favorite) { create(:favorite, user: other_user, post: other_post) }

          before do
            get user_path(user)
          end

          it "投稿が含まれる" do
            expect(response.body).to include(post.comment)
          end
          
          it "他ユーザの投稿を含まない" do
            expect(response.body).not_to include(other_post.comment)
          end
        end
        context "そのユーザの投稿がない場合" do
          it "「そのユーザの投稿はありません」が含まれる" do
            expect(response.body).to include("#{user.name}の投稿はありません")
          end
        end
      end

      context "ユーザのいいねを表示時" do
        context "そのユーザのいいねがある場合" do
          let(:post) { create(:post, user: user) } 
          let!(:cross_favorite) { create(:favorite, user: user, post: other_post) }
          let(:other_post) { create(:post, user: other_user) } 
          let!(:cross_other_favorite) { create(:favorite, user: other_user, post: post) }

          before do
            get favorites_user_path(user)
          end

          it "いいねした投稿が含まれる" do
            expect(response.body).to include(other_post.comment)
          end
          it "いいねしてない投稿を含まない" do
            expect(response.body).not_to include(post.comment)
          end
          it "他ユーザがいいねした投稿を含まない" do
            expect(response.body).not_to include(post.comment)
          end
        end

        context "そのユーザのいいねがない場合" do
          before do
            get favorites_user_path(user)
          end

          it "「そのユーザのいいねはありません」が含まれる" do
            expect(response.body).to include("#{user.name}のいいねはありません")
          end
        end
      end
    end

    describe "個別の内容" do
      context "ログインしない場合" do
        before do
          get user_path(user)
        end

        it "ユーザの設定ボタンを含まない" do
          expect(response.body).not_to include('class="bi bi-gear"')
        end

        it "current_userの設定画面にアクセスできない" do
          get edit_user_registration_path
          expect(response).to have_http_status(302)
        end
      end
      
      context "ゲストログインする場合" do
        before do
          sign_in guest_user
        end

        context "ゲスト自身のマイページにアクセスした場合" do
          before do
            get user_path(guest_user)
          end

          it "設定ボタンを含まない" do
            expect(response.body).not_to include('class="bi bi-gear"')
          end

          it "current_userの設定画面にアクセスできない" do
            get edit_user_registration_path
            expect(response).to have_http_status(302)
          end
        end

        context "他ユーザのマイページにアクセスした場合" do
          before do
            get user_path(user)
          end

          it "設定ボタンを含まない" do
            expect(response.body).not_to include('class="bi bi-gear"')
          end

          # ユーザ設定画面は、URLにid指定がなくcurrent_userの設定画面になるため、アクセス確認不要
        end
      end
      context "ユーザーログインする場合" do
        before do
          sign_in user
        end

        context "自ユーザのマイページにアクセスした場合" do
          before do
            get user_path(user)
          end

          it "設定ボタンが含まれる" do
            expect(response.body).to include('class="bi bi-gear"')
          end

          it "current_userの設定画面にアクセスできる" do
            get edit_user_registration_path
            expect(response).to have_http_status(:success)
          end
        end
        context "他ユーザのマイページにアクセスした場合" do
          before do
            get user_path(other_user)
          end

          it "設定ボタンを含まない" do
            expect(response.body).not_to include('class="bi bi-gear"')
          end
        end
      end
    end
  end
end
