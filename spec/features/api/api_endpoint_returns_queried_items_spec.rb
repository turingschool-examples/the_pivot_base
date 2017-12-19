require 'rails_helper'

describe "when a user hits the /search API with a query", type: :request do 
  it "returns a JSON response with items matching either title or description" do
    user = create(:user)
    key = create(:key, user_id: user.id)
    store = create(:store)
    item_1 = create(:item, title: "Dog-Collar")
    item_2 = create(:item, title: "Dog Toy")
    item_3 = create(:item, description: "Dogs love this piece of technology")
    item_4 = create(:item)

    
    get "/api/v1/search?type=items&q=dog&api_key=#{key.api_key}"

    items = JSON.parse(response.body)
    
    expect(items["search"].length).to eq 3
  end

  it "rejects requests without a token" do
    user = create(:user)
    key = create(:key, user_id: user.id)
    store = create(:store)
    item_1 = create(:item, title: "Dog-Collar")
    item_2 = create(:item, title: "Dog Toy")
    item_3 = create(:item, description: "Dogs love this piece of technology")
    item_4 = create(:item)

    
    get "/api/v1/search?type=items&q=dog"

    items = JSON.parse(response.body)

    expect(items["error"]).to eq "Result is Invalid"
  end 
end 