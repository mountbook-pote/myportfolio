require 'rails_helper'

RSpec.describe "About_page", type: :request do
  describe "get /about" do
    before do
      get about_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end
  end
end
