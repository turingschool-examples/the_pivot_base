require 'rails_helper'

describe "As a user" do
  describe "visits /orders" do
    it "can see all past orders" do
      user = create(:user)
      item = create(:item, price: 5.00)
			create(:order, user: user)
      order_1 = create(:order, user: user)
			create(:order_item, order: order_1, item: item, quantity: 2, unit_price: item.price)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/orders'

      expect(page).to have_css(".order", count: 2)

      within("#order-#{order_1.id}") do
        expect(page).to have_content(order_1.id)
        expect(page).to have_content(order_1.status.capitalize)
        expect(page).to have_content("$10.00")
      end
    end
  end
end
