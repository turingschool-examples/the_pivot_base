require 'rails_helper'

RSpec.describe "StoreService" do
  it "can create a proposed store from a name" do
    user = create(:user)
    StoreService.create_proposed_store(user, "new store")
    store = user.stores.first

    expect(store.name).to eq("new store")
  end

end
