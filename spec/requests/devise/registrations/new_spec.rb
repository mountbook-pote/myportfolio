require 'rails_helper'

RSpec.describe "Registration_page", type: :request do
  describe "get users/sign_up" do
    before do
      get new_user_registration_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end

    describe "内容の確認" do
      it "ユーザー名入力欄が含まれている" do
          expect(response.body).to include("ユーザー名を入力")
      end

      it "メールアドレス入力欄が含まれている" do
        expect(response.body).to include("メールアドレスを入力")
      end

      it "パスワード入力欄が含まれている" do
        expect(response.body).to include("パスワードを入力")
      end

      it "確認用パスワード入力欄が含まれている" do
        expect(response.body).to include("確認用パスワードを入力")
      end

      it "新規登録ボタンが含まれている" do
        expect(response.body).to include("新規登録")
        expect(response.body).to include('class="btn btn-secondary"')
      end
    end

    describe "動作の確認(deviseに追加した項目)" do
      it "名前を登録できる" do
        expect{
          post user_registration_path, params: {
            user: {
              name: "test001",
              email: "test001@example.com",
              password: "password",
              password_confirmation: "password"
            }
          }
        }.to change(User, :count).by(1)
      expect(User.last.name).to eq("test001")
      end
    end
  end
end
