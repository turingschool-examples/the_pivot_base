require 'rails_helper'

RSpec.describe Key, type: :model do
  it "can authenticate a valid key " do
    user = create(:user)
    key = Key.create(api_key: "c28070e54002a91b67db2089b53a51f4", user_id: user.id)
    
    expect(Key.authenticate_key?(key.api_key)).to eq true
  end 
end
