require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin)
    create(:user, first_name: "Gob")
  end
  it "click on delete and deletes the user" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_users_path

    click_on "Delete User"

    expect(User.all.count).to eq(1)
  end

end
