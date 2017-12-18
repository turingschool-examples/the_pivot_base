require 'rails_helper'

describe "when a user hits the /search API with a query" do 
  xit "returns a JSON response with items matching either title or description" do
    
    get "/api/v1/search?type=items&q=diapers&api_key=YOUR_REAL_KEY"

  end
end 