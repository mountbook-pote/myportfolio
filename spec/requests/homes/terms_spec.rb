require 'rails_helper'

RSpec.describe "Terms_page", type: :request do
  describe "get /terms" do
    before do
      get terms_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end
  end
end
