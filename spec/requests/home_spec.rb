require 'rails_helper'
require_relative '../support/devise'

RSpec.describe "homes", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }

    it "returns http success with sign_in" do
      sign_in user
      get root_path
      expect(response).to have_http_status(:success)
      end

    it "returns http unsuccess without sign_in" do
      get root_path
      expect(response).not_to have_http_status(:success)
    end

  end

end
