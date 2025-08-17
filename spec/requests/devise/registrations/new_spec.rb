require 'rails_helper'

RSpec.describe "Registration_page", type: :request do
  describe "get users/sign_up" do
    before do
      get new_user_registration_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end

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
end
