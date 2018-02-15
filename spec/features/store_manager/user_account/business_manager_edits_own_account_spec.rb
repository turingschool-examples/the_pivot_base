require 'rails_helper'

describe "As a Store Manager" do
    it "i can edit my own account" do
    store = create(:store)
    manager = create(:store_manager, store: store)
    role = Role.create(title: "store_manager")
    create(:user_role, user: manager, role: role)

    visit '/'

    click_on "Login"

    fill_in "session[email]", with: manager.email
    fill_in "session[password]", with: manager.password

    click_button("Login")
  
    new_email_address = "kramer@example.com"
    new_password      = "cosmo"

    visit admin_store_dashboard_index_path(store)
    click_on "Account"
    fill_in "user[email]", with: new_email_address
    fill_in "user[password]", with: new_password
    click_on "Submit"

    click_on "Logout"
    login_user(new_email_address, new_password)
    expect(current_path).to eq("/admin/#{store.slug}/dashboard")

  end

  xit "they cannot create users" do
    # they cannot visit platform_admin route to create or modify other users
    # they cannot visit business_admin route to create or modify other users

  end

end
