require 'rails_helper'

RSpec.describe "user can find items by attribute in params", type: :request do
  let!(:items)       { create_list(:item, 10, description: 'diapers') }
  let!(:description) { items.first.description }
  let!(:user)        { create(:user) }
  let!(:developer)   { create(:role, name: 'developer') }

  describe "GET /api/v1/search, with valid credentials" do
    before do
      stub_logged_in_user(user)
      DeveloperService.new(user: user).register_as_developer
    end

    it 'returns 10 item records by params' do
      get "/api/v1/search?type=items&q=#{description}&api_key=#{user.api_key[:key]}"

      expect(json).to_not be_empty
      expect(json.length).to eq(10)
      expect(json.first["description"]).to eq(items.first.description)
    end

    it "returns 10 item records, case insensitive, by given params" do
      get "/api/v1/search?type=items&q=DiApERs&api_key=#{user.api_key[:key]}"

      expect(json).to_not be_empty
      expect(json.length).to eq(10)
      expect(json.first["description"]).to eq(items.first.description)
    end
  end

  describe "GET /api/v1/search, with invalid credentials" do
    it "returns 404 status code and error" do
      get "/api/v1/search?type=items&q=#{description}&api_key=supercoolapikey"

      expect(json.length).to eq(1)
      expect(response).to have_http_status(401)
      expect(json).to eq({ "error"=>"Invalid Credentials" })
    end
  end
end