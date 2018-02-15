require "rails_helper"

describe "As a logged in Admin" do
  # let(:admin) { create(:user, role: "admin", email: "admin@example.com")}
  # let(:role) {create(:role, title: "store_admin")}
  # let(:user_role) {create(:user_role, user: admin, role: role)}

  it "I can modify my account data" do
    store = create(:store)
    admin = create(:store_admin, store: store)
    role = Role.create(title: "store_admin")
    create(:user_role, user: admin, role: role)


    # login_user(admin.email, admin.password)
    visit '/'

    click_on "Login"

    fill_in "session[email]", with: admin.email
    fill_in "session[password]", with: admin.password


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

  it "But I cannot modify any other user’s account data" do

    store = create(:store)
    admin = create(:store_admin, store: store)
    role = Role.create(title: "store_admin")
    create(:user_role, user: admin, role: role)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
    user = create(:user)

    expect {
      visit dashboard_index_path(user)
    }.to raise_error(ActionController::RoutingError)

  #getting a not found error (permissions... not sure what should be returned! )
  end

  it "returns a welcome message for admins" do
    store = create(:store)
    admin = create(:store_admin, store: store)
    role = Role.create(title: "store_admin")
    create(:user_role, user: admin, role: role)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
    visit admin_store_dashboard_index_path(store)
    expect(page).to have_content("You're logged in as an Administrator")

  end

  it "returns a 404 when a non-admin visits the admin dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
    expect {
      visit admin_dashboard_index_path
    }.to raise_error(ActionController::RoutingError)
  end
end
