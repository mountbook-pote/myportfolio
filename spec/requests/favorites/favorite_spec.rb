require 'rails_helper'

RSpec.describe "Favorite", type: :request do
  describe "いいねの作成と削除" do
    let (:user) { create(:user) }
    # 下は、変数名をpostにすると、postメソッドと被るためかエラーになるため、変数名をposutoにしている
    let!(:posuto) { create(:post, user: user) } 
    let!(:favorited_posuto) { create(:post, user: user) } 
    let!(:favorite) { create(:favorite, user: user, post: favorited_posuto) } # 削除用の既に存在するいいね

    context "ログインした場合" do
      before do
        sign_in user
      end

      it "投稿をいいねできる" do
        expect {
          post post_favorite_path(posuto), headers: { 'ACCEPT' => 'application/javascript' }
        }.to change(Favorite, :count).by(1)
      end
      it "いいねを削除できる" do
        expect {
          delete post_favorite_path(favorited_posuto), headers: { 'ACCEPT' => 'application/javascript' }
        }.to change(Favorite, :count).by(-1)
      end
    end
    
    context "ログインしない場合" do
      it "投稿をいいねできない" do
        expect {
          post post_favorite_path(posuto), headers: { 'ACCEPT' => 'application/javascript' }
        }.not_to change(Favorite, :count)
      end
    end
  end
end
