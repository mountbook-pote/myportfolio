require 'rails_helper'

RSpec.describe "top", type: :request do
  describe "GET /top" do
    before do
      get root_path
    end

    it "リクエストが成功する" do
      puts "DB adapter: #{ActiveRecord::Base.connection.adapter_name}"
      expect(response).to have_http_status(:success)
    end
  end
end
