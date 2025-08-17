require 'rails_helper'

RSpec.describe "Login_page", type: :request do
  describe "get users/sign_in" do
    before do
      get new_user_session_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end

    it "メールアドレス入力欄が含まれている" do
      expect(response.body).to include("メールアドレスを入力")
    end

    it "パスワード入力欄が含まれている" do
      expect(response.body).to include("パスワードを入力")
    end

    it "ログイン記憶チェックボックスが含まれている" do
      expect(response.body).to include("ログインを記憶する")
    end

    it "ログインボタンが含まれている" do
      expect(response.body).to include("ログイン")
      expect(response.body).to include('class="btn btn-secondary"')
    end
  end
end
