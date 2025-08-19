require 'rails_helper'

RSpec.describe "Post", type: :model do
  describe "#self.search_with_ransack" do
    let!(:post_european){ create(:post, met_object: create(:met_object, department: "European Paintings")) }
    let!(:post_medieval){ create(:post, met_object: create(:met_object, department: "Medieval Art")) }
    let!(:post_egyptian){ create(:post, met_object: create(:met_object, department: "Egyptian Art")) }

    context "params[:q]がnilの時" do
      let(:params) { {} }

      it "全ての作品を取得する" do
        expect(Post.search_with_ransack(params)).to match_array(Post.all)
      end
    end

    context "params[:q]のmet_object_department_inが空の時" do
      let(:params){ {q: {met_object_department_in: ""} } }

      it "作品の取得件数は0件となる" do
        expect(Post.search_with_ransack(params)).to match_array(Post.none)
      end
    end
  end

  describe "バリデーション" do
    let(:user){ create(:user) }
    let(:met_object){ create(:met_object) }
    let(:post){ create(:post) }
    let!(:favorite){ create(:favorite, post: post) }

    it "コメントが空の場合は無効" do
      expect(Post.new(user: user, met_object: met_object, comment: "")).not_to be_valid
    end

    it "コメントが141文字の場合は無効" do
      expect(Post.new(user: user, met_object: met_object, comment: "a" * 141)).not_to be_valid
    end

    it "コメントが140文字以内の場合は有効" do
      expect(Post.new(user: user, met_object: met_object, comment: "a" * 140)).to be_valid
    end

    it "投稿を削除するとそれに紐づくいいねも削除される" do
      expect{post.destroy}.to change{ Favorite.count }.by(-1)
      expect(Favorite.find_by(id: favorite.id)).to be_nil
    end
  end
end
