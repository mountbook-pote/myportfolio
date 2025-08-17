require 'rails_helper'

RSpec.describe "policy", type: :request do
  describe "GET /policy" do
    before do
      get policy_path
    end

    it "リクエストが成功する" do
      expect(response).to have_http_status(:success)
    end
  end
end
