require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin, email: "platform_admin@example.com")
    role = create(:role, name: "store_admin")
    store = create(:store)
    create(:user_role, user: @platform_admin, role: role, store: store)
  end
  it "sees all the stores in the page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@platform_admin)
    visit platform_admin_dashboard

    expect(current_path).to eq("/platform_admin/dashboard")
    expect(page).to have_content("Manage Accounts")
    expect(page).to have_content("Gob")
    expect(page).to have_content("MyString")
  end
end
