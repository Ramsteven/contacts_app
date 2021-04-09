require 'rails_helper'

RSpec.describe "users", type: :request do
  let(:user) { create(:user) }

  describe "REQUEST /user with out sign_in " do
    it "returns http success get request" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
      end
    it "returns http success post request" do
      post "/users/sign_in"
      expect(response).to have_http_status(:success)
    end

    it "returns http not success destroy request sign_out" do
      delete "/users/sign_out"
      expect(response).not_to have_http_status(:success)
    end


    it "returns http not success new password" do
      get "/users/password/new"
      expect(response).to have_http_status(:success)
    end

    it "returns http not success" do
      get "/users/password/edit"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http  not success" do
      patch "/users/password"
      expect(response).to have_http_status(:success)
    end

    it "returns http not success" do
      put "/users/password"
      expect(response).to have_http_status(:success)
    end

    it "returns http not success" do
      post "/users/password"
      expect(response).to have_http_status(:success)
    end
    
    it "returns http success" do
      get "/users/sign_up"
      expect(response).to have_http_status(:success)
    end

    it "returns http not success edit" do
      get "/users/edit"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http  not success" do
      patch "/users"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http not  success" do
      put "/users"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http  not success" do
      delete "/users"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http not success" do
      post "/users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "REQUEST /user with sign_in " do
    before(:each) do sign_in user end 
    it "returns http  not success get request" do
      get "/users/sign_in"
      expect(response).not_to have_http_status(:success)
      end
    it "returns http not success post request" do
      post "/users/sign_in"
      expect(response).not_to have_http_status(:success)
    end

    it "returns http success request sign_out" do
      delete "/users/sign_out"
      expect(response).to have_http_status(302)
    end

   
    it "returns http success" do
      get "/users/password/new"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      get "/users/password/edit"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      patch "/users/password"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      put "/users/password"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      post "/users/password"
      expect(response).to have_http_status(302)
    end

    
    it "returns http success" do
      get "/users/sign_up"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      get "/users/edit"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      patch "/users"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      put "/users"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      delete "/users"
      expect(response).to have_http_status(302)
    end

    it "returns http success" do
      post "/users"
      expect(response).to have_http_status(302)
    end

  end
end

