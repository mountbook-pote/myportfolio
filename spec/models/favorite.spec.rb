require 'rails_helper'

RSpec.describe "Favorite", type: :model do
  describe "バリデーション" do
    let(:user){ create(:user) }
    let(:post){ create(:post) }
    let!(:favorite){ create(:favorite, user: user, post: post) }

    it "1人のユーザが同じ投稿に2度いいねできない" do
      expect(Favorite.new(user: user, post: post)).not_to be_valid
    end
  end
end
