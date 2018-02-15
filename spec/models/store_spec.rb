require 'rails_helper'

RSpec.describe Store, type: :model do
  it "has valid attributes" do 
    store = Store.create(name: "Guess", slug: "guess", status:"active")

    expect(store.name).to eq("Guess")
    expect(store.slug).to eq("guess")
    expect(store.status).to eq("active")

  end
end
