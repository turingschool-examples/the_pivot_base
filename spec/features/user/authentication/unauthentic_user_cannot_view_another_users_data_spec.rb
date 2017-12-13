require 'rails_helper'

RSpec.feature "Unauthenticated users security" do
  before(:each) do
    @order = create(:order)
    @category = create(:category)
    @item = create(:item, category_id: @category.id)
  end
  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      visit dashboard_index_path

      expect(current_path).to eq(login_path)

      visit order_path(@order)

      expect(current_path).to eq(login_path)
    end

    it "I should be redirected to login/create account when I try to check out" do
      visit item_path(@item)

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to_not have_content("Checkout")
			expect(page).to have_content("Login Create new account")

			#click_on("Login")
			first(:link, "Login").click

      expect(current_path).to eq(login_path)
    end

    it "I cannot view the administrator screens or use administrator functionality" do
      expect {
        visit admin_dashboard_index_path
      }.to raise_exception(ActionController::RoutingError)
    end
  end
end
