RSpec.describe "As a user" do
	describe "visits /orders" do
		it "can see all past orders" do
			two_items
			user = User.create(first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing")
			order_1 = user.orders.create(status: "ordered")
			OrderItem.create(order: order_1, item: @item_one)
			OrderItem.create(order: order_1, item: @item_two)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			visit '/orders'
			click_on order_1.created_at
			expect(current_path).to eq(order_path(order_1))
			expect(page).to have_content("Total Price: $20.0")
		end
	end
end