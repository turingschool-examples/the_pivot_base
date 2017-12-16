require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:all) do
    @platform_admin = create(:platform_admin, email: "platform_admin@example.com")
    role = create(:role, name: "store_admin")
    store = create(:store)
    create(:store_user, user: @platform_admin, role: role, store: store)
    3.times do
      create(:store)
    end
  end
  it "sees all the stores in the page" do
    login_user(@platform_admin.email, @platform_admin.password)
    visit platform_admin_dashboard_path

    expect(current_path).to eq("/platform_admin/dashboard")
    expect(page).to have_content("Manage Accounts")
    expect(page).to have_content("Gob")
    expect(page).to have_content("MyString1")
  end
end
