require 'rails_helper'

RSpec.describe "User(deviseに追加した項目)", type: :model do
  describe "#self.guest" do
    let(:guest_user){ User.guest }

    context "ゲストユーザが存在しない場合" do

      it "ゲストユーザを新規作成する" do
        expect{guest_user}.to change{User.count}.by(1) # 状態変化の確認には{}を使う
        expect(guest_user.name).to eq(User::GUEST_USER_NAME)
      end
    end

    context "ゲストユーザが存在する場合" do
      let!(:existed_guest_user){ create(:user, name: User::GUEST_USER_NAME, email: User::GUEST_USER_EMAIL) }

      it "既存のゲストユーザを返す" do
        expect{guest_user}.not_to change{User.count}
        expect(guest_user.id). to eq(existed_guest_user.id) # idの一致を入れる
        expect(guest_user.name). to eq(existed_guest_user.name)
        expect(guest_user.email). to eq(existed_guest_user.email)
      end
    end
  end

  describe "#guest?" do
    let(:user){ create(:user) }
    let(:guest_user){ User.guest }

    it "ユーザのメールアドレス != ゲストのメールアドレスだとfalseを返す" do
      expect(user.guest?).to be false
    end

    it "ユーザのメールアドレス != ゲストのメールアドレスだとtrueを返す" do
      expect(guest_user.guest?).to be true
    end
  end

  describe "バリデーション" do
    let(:user){ create(:user) }
    let!(:post){ create(:post, user: user) }
    let!(:favorite){ create(:favorite, user: user) }

    it "ユーザー名が空の場合は無効" do
      expect(
        User.new(
          name: "", 
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
      ).not_to be_valid
    end

    it "ユーザー名が11文字の場合は無効" do
      expect(
        User.new(
          name: "a" * 11, 
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
      ).not_to be_valid
    end

    it "ユーザ名が10文字以内の場合は有効" do
      expect(
        User.new(
          name: "a" * 10, 
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
      ).to be_valid
    end

    it "ユーザを削除するとそれに紐づく投稿も削除される" do
      expect{user.destroy}.to change{ Post.count }.by(-1)
      expect(Post.find_by(id: post.id)).to be_nil
    end

    it "ユーザを削除するとそれに紐づくいいねも削除される" do
      expect{user.destroy}.to change{ Favorite.count }.by(-1)
      expect(Favorite.find_by(id: favorite.id)).to be_nil
    end

    describe "#image_content_type" do
      it "content_typeがjpeg, gif, png以外だと無効" do
        image_file = Tempfile.new(['temp_image', '.txt'])
        image_file.write("a" * 1.megabytes.to_i)
        image_file.rewind

        user.image.attach(
          io: image_file,
          filename: 'temp_image.txt',
          content_type: 'text/plain'       
        )

        expect(user).not_to be_valid
        expect(user.errors[:image]).to include(
          # [:image]が配列なので、要素内がが完全一致しないといけないため、全文を正しく書く
          "：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。"
        )
      end

      it "content_typeがjpeg, gif, pngだと有効" do
        file_contexts = ["jpeg", "gif", "png"]
        file_contexts.each do |context|
          image_file = Tempfile.new(['temp_image', ".#{context}"])
          image_file.write("a" * 1.megabytes.to_i)
          image_file.rewind

          user.image.attach(
            io: image_file,
            filename: "temp_image.#{context}",
            content_type: "image/#{context}"
          )
          expect(user).to be_valid
        end
      end
    end

    describe "#image_size" do
      it "ユーザ画像サイズが1MBより大きいと無効" do
        image_file = Tempfile.new(['temp_image', '.jpg'])
        image_file.write("a" * 1.1.megabytes.to_i)
        image_file.rewind #ポインタの位置を先頭に移動させる

        user.image.attach(
          io: image_file,
          filename: 'temp_image.jpg',
          content_type: 'image/jpeg'       
        )

        expect(user).not_to be_valid
        expect(user.errors[:image]).to include("：1MB以下のファイルをアップロードしてください。")
      end

      it "ユーザ画像サイズが1MB以下だと有効" do
        image_file = Tempfile.new(['temp_image', '.jpg'])
        image_file.write("a" * 1.megabytes.to_i)
        image_file.rewind 

        user.image.attach(
          io: image_file,
          filename: 'temp_image.jpg',
          content_type: 'image/jpeg'       
        )

        expect(user).to be_valid
      end
    end
  end
end
