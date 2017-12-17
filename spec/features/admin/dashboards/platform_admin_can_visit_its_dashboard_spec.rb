require 'rails_helper'

describe 'when a platform admin visits its dashboard' do
  before(:each) do
    @platform_admin = create(:platform_admin, email: "platform_admin@example.com")
    store = create(:store, name: "A&A")
    2.times do
      create(:store)
    end
    5.times do |n|
      create(:store_admin)
      create(:store_manager)
      create(:user, first_name: "Gob#{n}")
    end
  end

  it "sees all the stores in the page" do
    login_user(@platform_admin.email, @platform_admin.password)
    visit platform_admin_dashboard_path

    expect(current_path).to eq("/platform_admin/dashboard")
    expect(page).to have_content("Manage Accounts")
    expect(page).to have_content("Gob")
    expect(page).to have_content("A&A")
  end

  it "clicks on manage account and sees all the users" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_dashboard_path

    click_on "Manage Accounts"

    expect(current_path).to eq("/platform_admin/users")
    expect(User.account_manager(@platform_admin.id).count).to eq(15)
    expect(page).to have_content("Gob")
  end

  it "click on a user name and takes you to the user edit page" do
    login_user(@platform_admin.email, @platform_admin.password)

    visit platform_admin_users_path

    click_on "Gob0"

    expect(current_path).to eq("/platform_admin/users/4/edit")
  end

end
