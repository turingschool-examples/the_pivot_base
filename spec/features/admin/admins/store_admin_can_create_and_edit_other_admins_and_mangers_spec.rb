require 'rails_helper'

RSpec.feature "store admin can manage other admins" do
  it "can remove admin role" do
    admin1, admin2 = create_list(:user, 2)
    admin_role = create(:role, name: "store admin")
    admin1.roles << admin_role
    admin2.roles << admin_role
    stub_logged_in_user(admin1)

    visit "/admin/dashboard"
    click_on "Manage Admins"

    expect(page).to have_content(admin2.first_name)
    expect(page).to have_content(admin2.email)
    expect(page).to_not have_content(admin1.email)

    click_on "Demote"

    expect(page).to_not have_content(admin2.first_name)
    expect(User.find(admin2.id).roles.count).to eq(0)
  end

  xit "can edit manager role" do
    admin1, admin2 = create_list(:user, 2)
    admin_role = create(:role, name: "store admin")
    admin1.roles << admin_role
    admin2.roles << admin_role
    stub_logged_in_user(admin1)

    visit "/admin/dashboard"
    click_on "Manage Admins"
    click_on "Edit", match: :first
    
    #add extra functionality later
  end

  xit "can create new admin" do

  end
end
