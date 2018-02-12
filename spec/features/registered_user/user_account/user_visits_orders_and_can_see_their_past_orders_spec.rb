require 'rails_helper'

describe "As a user" do
  describe "visits /orders" do
    it "can see all past orders" do
      user = create(:registered_user)
      role = Role.create(title: "registered_user")
      UserRole.create(user: user, role: role)
      # user.roles << Role.find_by(title: "registered_user")
      item = create(:item, price: 5.00)
      items_with_quantity = [ {item => 2} ]
      order_1 = Order.create(user: user, status: 1)
      order_2 = Order.create(user: user, status: 1)
      order_3 = Order.create(user: user, status: 1)

      order_1.add({item => 2})
      order_2.add({item => 2})
      order_3.add({item => 2})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit orders_path
      # save_and_open_page

      expect(page).to have_css(".order", count: 3)

      within("#order-#{order_1.id}") do
        expect(page).to have_content(order_1.id)
        expect(page).to have_content(order_1.status.capitalize)
        expect(page).to have_content("$10.00")
      end
      within("#order-#{order_3.id}") do
        expect(page).to have_content(order_3.id)
        expect(page).to have_content(order_1.status.capitalize)
        expect(page).to have_content("$10.00")
      end
    end
  end
end
