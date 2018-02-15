require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it "has valid attributes" do 
    user_role = UserRole.create(user_id: 1, role_id: 1)

    expect(user_role.user_id).to eq(1)
    expect(user_role.role_id).to eq(1)
  end
  it "belongs to a user" do
     user_role = UserRole.create(user_id: 1, role_id: 1)
     user = create(:user)

     expect(user_role).to respond_to(:user)
  end

  it "belongs to a role" do 
    user_role = UserRole.create(user_id: 1, role_id: 1)
    role = create(:role)

    expect(user_role).to respond_to(:role)
  end
end
