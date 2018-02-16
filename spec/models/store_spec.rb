require 'rails_helper'

RSpec.describe Store, type: :model do
  it "has valid attributes" do 
    store = Store.create(name: "Guess", slug: "guess", status:"active")

    expect(store.name).to eq("Guess")
    expect(store.slug).to eq("guess")
    expect(store.status).to eq("active")
  end
  it "has to have a name to be valid" do 
    store = build(:store, name: nil)
    expect(store).to be_invalid
  end
  it "must have a unique name to be valid" do 
    store1 = create(:store, name: "Guess")
    store2 = build(:store, name: "Guess")

    expect(store2).to be_invalid
  end

  it "can generate a slug" do 
   store =  Store.create(name: "Diesel")

    expect(store.generate_slug).to eq("diesel")
  end

  it "can turn its slug to a param" do 
    store =  Store.create(name: "Diesel")

    expect(store.to_param).to eq("diesel")
  end

  describe "relationships" do 
    it {should have_many(:items)}
    it {should have_many(:order_items)}
    it {should have_many(:orders)}
    it {should have_many(:users)}
  end
end
