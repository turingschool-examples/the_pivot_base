require 'rails_helper'

RSpec.describe "user can find items by attribute in params", type: :request do
  let!(:items) { create_list(:item, 10, description: 'diapers') }

  describe "GET /api/v1/search" do
    it 'returns 10 diaper records' do
      get "/api/v1/search?type=items&q=#{items.first.description}"

      expect(json).to_not be_empty
      expect(json.length).to eq(10)
      expect(json.first["description"]).to eq(items.first.description)
    end

    it "returns 10 diaper records case insensitive" do
      get "/api/v1/search?type=items&q=DiApERs"

      expect(json).to_not be_empty
      expect(json.length).to eq(10)
      expect(json.first["description"]).to eq(items.first.description)
    end
  end
end