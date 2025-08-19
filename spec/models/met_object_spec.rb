require 'rails_helper'

RSpec.describe "Met_objects", type: :model do
  describe "#fetch_all_departments_works_at_random" do
    # データの取得や通常の変数もlet使用可能
    let(:fetched_results) { MetObject.fetch_all_departments_works_at_random(all_departments, fetch_each_number) }
    let(:all_departments) { ["European Paintings", "Medieval Art", "Egyptian Art"] }
    let(:fetch_each_number) { 2 }

    context "正常なデータのみが存在する場合" do
      let!(:met_european){ create_list(:met_object, 6, department: "European Paintings") }
      let!(:met_medieval){ create_list(:met_object, 6, department: "Medieval Art") }
      let!(:met_egyptian){ create_list(:met_object, 6, department: "Egyptian Art") }
      
      it "合計取得件数＝全てのジャンル×指定した件数になる" do
        expect(fetched_results.count).to be 6
      end

      it "各ジャンル取得件数＝指定した件数になる" do
        expect(fetched_results.count{ |result| result.department == "European Paintings" }).to be 2
        expect(fetched_results.count{ |result| result.department == "Medieval Art" }).to be 2
        expect(fetched_results.count{ |result| result.department == "Egyptian Art" }).to be 2
      end

      it "ランダムに取得されていることが確認できる(2回の取得結果が異なることによる)" do
        result1 = fetched_results
        result2 = fetched_results
        ids1 = result1.map(&:id)
        ids2 = result1.map(&:id)
        expect(ids1).not_to be eq(ids2)
      end
    end

    context "画像URLがnilやemptyのデータが存在し、取得される可能性がある場合" do
      let!(:met_european){ create(:met_object, department: "European Paintings") }
      let!(:met_european_invalid_nil) do
        create(:met_object, department: "European Paintings", primary_image_small: nil)
      end
      let!(:met_european_invalid_empty) do
        create(:met_object, department: "European Paintings", primary_image_small: "")
      end
      
      it "画像URLがnilやemptyのデータが取得されない" do
        results = fetched_results
        expect(results.any?{|result| result.primary_image_small == nil}). to be false
        expect(results.any?{|result| result.primary_image_small == ""}). to be false
      end
    end
  end

  describe "#fetch_department_works_at_random" do
    let(:fetched_results) { MetObject.fetch_department_works_at_random(department, fetch_number) }
    let(:department) { "European Paintings" }
    let!(:other_department) { "Medieval Art" }
    let(:fetch_number) { 2 }

    context "正常なデータのみが存在する場合" do
      let!(:met_european){ create_list(:met_object, 20, department: "European Paintings") }
      
      it "指定したジャンルから、指定した件数を取得できる" do
        expect(fetched_results.count).to be 2
        expect(fetched_results.count{ |result| result.department == "European Paintings" }).to be 2
      end

      it "ランダムに取得されていることが確認できる(2回の取得結果が異なることによる)" do
        result1 = fetched_results
        result2 = fetched_results
        ids1 = result1.map(&:id)
        ids2 = result1.map(&:id)
        expect(ids1).not_to be eq(ids2)
      end
    end

    context "別ジャンルのデータが取得される可能性がある場合" do
      let!(:met_european){ create_list(:met_object, 1, department: "European Paintings") }
      let!(:met_medieval){ create_list(:met_object, 1, department: "Medieval Art") }

      it "別ジャンルのデータが取得されない" do
        results = fetched_results
        expect(results.any? { |result| result.department == "Medieval Art" }).to be false
      end
    end

    context "画像URLがnilやemptyのデータが存在し、取得される可能性がある場合" do
      let!(:met_european){ create(:met_object, department: "European Paintings") }
      let!(:met_european_invalid_nil) do
        create(:met_object, department: "European Paintings", primary_image_small: nil)
      end
      let!(:met_european_invalid_empty) do
        create(:met_object, department: "European Paintings", primary_image_small: "")
      end
      
      it "画像URLがnilやemptyのデータが取得されない" do
        results = fetched_results
        expect(results.any?{|result| result.primary_image_small == nil}). to be false
        expect(results.any?{|result| result.primary_image_small == ""}). to be false
      end
    end
  end
end
