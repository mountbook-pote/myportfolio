require 'rails_helper'

RSpec.describe "Posts", type: :model do
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
end
