require 'rails_helper'

RSpec.feature "As a Platform admin " do
  let!(:admin)          { create(:platform_admin) }
  let!(:platform_admin) { Role.new(name: 'platform_admin') }
  let!(:pending)        { create(:store, name: "Vandelay Industries") }
  let!(:suspended)      { create(:store, name: "Innotech", status: 1) }
  let!(:active)         { create(:store, name: "Bluth Company", status: 2) }
  let!(:scrub_user)     { create(:user) }

  describe "When I visit admin/dashboard" do

    before { login_user(admin.email, admin.password) }

    it "I see a stores and I can approve a pending store" do
      expect(current_path).to eq('/admin/dashboard')

      admin.roles << platform_admin

      click_on "View Stores"

      expect(page).to have_content('All Stores (3)')
      expect(page).to have_content("Pending (1)")
      expect(page).to have_content('Suspended (1)')
      expect(page).to have_content('Active (1)')

      click_on "Pending"

      expect(current_path).to eq('/admin/stores/pending')

      click_on pending.name
      click_on "Approve Store"

      expect(current_path).to eq('/admin/stores')
      expect(page).to have_content('Active (2)')
    end
  end

  describe "as a default user" do
    before { login_user(scrub_user.email, scrub_user.password) }
    it "i should receive status code 404 and a not found page" do
       expect { visit '/admin/dashboard'}.to raise_error(ActionController::RoutingError)
    end
  end

  describe "as a default admin user" do
    before { login_user(admin.email, admin.password) }
    it "i should receive status code 404 and a not found page" do
       expect { visit '/admin/dashboard/stores'}.to raise_error(ActionController::RoutingError)
    end
  end
end
