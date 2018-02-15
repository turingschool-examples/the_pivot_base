require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it "has valid attributes" do 
    user_role = UserRole.create(user_id: 1, role_id: 1)

    expect(user_role.user_id).to eq(1)
    expect(user_role.role_id).to eq(1)
  end

  describe "relationships" do
     it {should belong_to(:user)}
     it {should belong_to(:role)}
  end

end
