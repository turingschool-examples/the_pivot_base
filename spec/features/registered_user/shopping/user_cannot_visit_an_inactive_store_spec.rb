require 'rails_helper'

#this one is required by the instructors per the spec
feature "Registered User attempts to visit inactive store" do

  describe "As a registered user" do
    it "I cannot visit an inactive store" do
      user = create(:user, email: "testerson@testmail.com", password: "testing")
      store = create(:store, status: 2)
      role = create(:role)
      user_role = create(:user_role, user: user, role: role)

      visit "/#{store.slug}/items"
      expect(page).to have_content("store is no longer active")
    end
  end

end
