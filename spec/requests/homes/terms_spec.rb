require 'rails_helper'

RSpec.describe "terms", type: :request do
  describe "GET /terms" do
    before do
      get terms_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end
  end
end
