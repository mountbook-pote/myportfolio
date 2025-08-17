require 'rails_helper'

RSpec.describe "about", type: :request do
  describe "GET /about" do
    before do
      get about_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end
  end
end
