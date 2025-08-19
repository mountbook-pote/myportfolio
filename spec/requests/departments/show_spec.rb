require 'rails_helper'

RSpec.describe "Department_show", type: :request do
  describe "get /departments/id" do

    describe "共通の項目" do
      before do
        get department_path(DepartmentsController::DEPARTMENT_IDS.key("All Departments"))
      end

      it "リクエストが成功する" do
        expect(response).to have_http_status(:success)
      end

      it "セレクトボックスが含まれている" do
        expect(response.body).to include('id="department-id"')
      end

      it "鑑賞ボタンが含まれている" do
        expect(response.body).to include('id="select-department-button"')
      end

      describe "作品情報" do
        context "作品が存在する時" do
          let!(:met_object){ create(:met_object) }
          
          before do
            get department_path(DepartmentsController::DEPARTMENT_IDS.key("All Departments"))
          end

          it "作品画像URLが含まれる" do
            expect(response.body).to include(met_object.primary_image_small)
          end

          it "タイトルが含まれる" do
            expect(response.body).to include(met_object.title)
          end

          it "制作者が含まれる" do
            expect(response.body).to include(met_object.artist_display_name)
          end

          it "制作年が含まれる" do
            expect(response.body).to include(met_object.object_date)
          end

          it "投稿ボタンが含まれる" do
            expect(response.body).to include("この作品を投稿")
          end
        end

        context "作品が１つもない時" do
          it "「作品が用意されていません」が含まれる" do
            expect(response.body).to include("作品が用意されていません")
          end
        end
      end
    end

    describe "個別の項目" do
      context "全てのジャンルを鑑賞する時" do
        let!(:met_object){ create(:met_object) }

        before do
          get department_path(DepartmentsController::DEPARTMENT_IDS.key("All Departments"))
        end
        # 作品の合計件数や各ジャンルが指定した件数分取得できることはmet_object_specで確認済
        it "作品情報が含まれる" do
          expect(response.body).to include(met_object.primary_image_small)
        end

        it "作品情報にジャンル項目が含まれる" do
          expect(response.body).to include('class="department_for_rspec"')
        end
      end

      context "個々のジャンルを鑑賞する時" do
        let!(:met_european){ create(:met_object, department: "European Paintings") }

        before do
          get department_path(DepartmentsController::DEPARTMENT_IDS.key("European Paintings"))
        end
        # 指定ジャンルの件数取得や他ジャンルが混入しないことはmet_object_specで確認済
        it "作品情報が含まれる" do
          expect(response.body).to include(met_european.primary_image_small)
        end

        it "作品情報にジャンル項目が含まれない" do
          expect(response.body).not_to include('class="department_for_rspec"')
        end
      end
    end
  end
end
