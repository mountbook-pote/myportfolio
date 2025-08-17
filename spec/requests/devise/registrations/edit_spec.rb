require 'rails_helper'

RSpec.describe "Registration_edit", type: :request do
  describe "get users/edit" do
    let(:user) { create(:user, :with_icon_image) }
    let(:guest_user) { User.guest }

    describe "アクセスの確認" do

      context "ログインしない場合" do
        before do
          get edit_user_registration_path
        end

        it "ユーザーの設定画面にアクセスできない" do # 設定画面はcurrent_userのみで、他ユーザは存在しない。
          expect(response).to have_http_status(302)
        end
      end

      context "ゲストログインした場合" do
        before do
          sign_in guest_user
          get edit_user_registration_path
        end

        it "ユーザーの設定画面にアクセスできない" do
          expect(response).to have_http_status(302)
        end
      end
      
      context "ユーザーログインした場合" do
        before do
          sign_in user
          get edit_user_registration_path
        end

        it "ユーザーの設定画面にアクセスできる" do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe "内容の確認" do
      before do
        sign_in user
        get edit_user_registration_path
      end

      it "ユーザ画像が含まれる" do
        expect(user.image).to be_attached
      end

      it "ユーザ画像をデフォルトに戻すボタンが含まれる" do
        expect(response.body).to include("元に戻す")
      end

      it "ユーザ画像をデフォルトに戻すことができる" do
        expect {
          delete delete_icon_user_path(user)
        }.to change { user.reload.image.attached? }.from(true).to(false)
      end

      it "ユーザー名入力欄が含まれている" do
        expect(response.body).to include("ユーザー名を入力")
      end

      it "メールアドレス入力欄が含まれている" do
        expect(response.body).to include("メールアドレスを入力")
      end

      it "新しいパスワード入力欄が含まれている" do
        expect(response.body).to include("新しいパスワードを入力")
      end

      it "新しいパスワード(確認用)入力欄が含まれている" do
        expect(response.body).to include("確認用パスワードを入力")
      end

      it "現在のパスワード入力欄が含まれている" do
        expect(response.body).to include("現在のパスワードを入力")
      end

      it "更新ボタンが含まれている" do
        expect(response.body).to include("更新")
        expect(response.body).to include('class="btn btn-secondary"')
      end

      it "キャンセルボタンが含まれている" do
        expect(response.body).to include("キャンセル")
        expect(response.body).to include('class="btn btn-outline-secondary cancel"')
      end

      it "退会するボタンが含まれている" do
        expect(response.body).to include("退会する")
        expect(response.body).to include('class="btn btn-danger"')
      end
    end  
  end
end
