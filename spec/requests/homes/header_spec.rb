require 'rails_helper'

RSpec.describe "Header", type: :request do
  describe "get /top" do # ヘッダーの確認をトップページで行う
    let(:user) { create(:user, :with_icon_image) }
    let(:guest_user) { User.guest }

    describe "表示項目" do
      context "ログインしない場合" do
        before do
          get root_path
        end

        it "ゲスト用ログインボタンを含む" do
          expect(response.body).to include('ゲスト用')
        end

        it "ログインボタンを含む" do
          expect(response.body).to include('ログイン')
        end

        it "新規登録ボタンを含む" do
          expect(response.body).to include('新規登録')
        end

        it "ユーザ画像を含まない" do
          # userに関する内容が何もない状態でuser.image確認すると失敗するので画像名で確認
          expect(response.body).not_to include("sample.jpg")
        end

        it "ユーザ名を含まない" do
          expect(response.body).not_to include(user.name)
        end

        it "メニューバー：マイページを含まない" do
          expect(response.body).not_to include('マイページ')
        end

        it "メニューバー：設定を含まない" do
          expect(response.body).not_to include('設定')
        end

        it "メニューバー：ログアウトを含まない" do
          expect(response.body).not_to include('ログアウト')
        end
      end

      context "ログインした場合" do
        before do
          sign_in user
          get root_path
        end

        it "ゲスト用ログインボタンを含まない" do
          expect(response.body).not_to include('ゲスト用')
        end

        it "ログインボタンを含まない" do
          expect(response.body).not_to include('ログイン')
        end

        it "新規登録ボタンを含まない" do
          expect(response.body).not_to include('新規登録')
        end

        it "ユーザ画像を含む" do
          expect(user.image).to be_attached
        end

        it "ユーザ名を含む" do
          expect(response.body).to include(user.name)
        end

        it "メニュー：マイページを含む" do
          expect(response.body).to include('マイページ')
        end

        it "メニュー：設定を含む" do
          expect(response.body).to include('設定')
        end

        it "メニュー：ログアウトを含む" do
          expect(response.body).to include('ログアウト')
        end
      end

      context "ゲストとしてログインした場合" do
        before do
          sign_in guest_user
          get root_path
        end

        it "メニュー：設定を含まない" do
          expect(response.body).not_to include('設定')
        end
      end
    end

    describe "動作項目(deviseに追加した項目)" do
      context "ログインしない場合" do
        before do
          get root_path
        end

        it "ゲストログインができる" do
          post users_guest_login_path
          # 上記でsign_in guest_userはpost_controllerで行われるため記述不要
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("ゲストとしてログインしました")
        end
      end

      context "ログインした場合" do
        before do
          sign_in user
          get root_path
        end

        it "ゲストログインができない" do
          post users_guest_login_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("すでにログインしています")
        end
      end
    end
  end
end
