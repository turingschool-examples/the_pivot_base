require 'rails_helper'

feature "As an authenticated user" do
  describe "when I checkout" do

  before do
  end


      it "with a valid shipping address" do

        role = Role.create(title: "registered_user")
        user = User.create(first_name: "Lauren", last_name: "Billington", password: "password", email: "billie@billington.com", address: "642 E 10th Street ", address_2: "", city: "Bloomington", state: "IN", zip: "47408", phone: "303-867-5309")
        user.roles << role
        login_user(user.email, user.password)
        cart = Cart.new({"1" => 1, "2" => 2})
        cart_decorator = CartDecorator.new(cart)
        package = PackageDecorator.new(cart)

          visit shipping_path #(errors out, and I cant seem to intercept the controller call. Should I make a fake test controller since this is a weird multi-part post/get API call?)
          #I could just skip the feature test and work only on
          save_and_open_page
          @shipping_rates = ShippingRate.rate(user, package)

          expect(current_path).to eq(shipping_path)
          expect(page).to have_content("SHIPPING: 21.98")
          expect(page).to have_content("Total: 21.98")


          click_on "Checkout"
          expect(current_path).to be()

          # my shipping cost is also added to my order total in a new total
          # I can click the button to place my order: sends to new_order_path
          # I see a screen with my order and an option to pay
        end

  end
end
