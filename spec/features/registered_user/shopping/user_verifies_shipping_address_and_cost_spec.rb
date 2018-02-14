require 'rails_helper'

feature "As an authenticated user" do
  before do
    role = Role.create(title: "registered_user")
    user = User.create(first_name: "Billie", last_name: "Billington", password: "password", email: "billie@billington.com", address: "1234 5th street", address_2: "#321", city: "Bloomington", state: "IA", zip: "12345", phone: "303-867-5309")
    user.user_roles.update(role: role.id)
    login_user(user.email, user.password)
    cart = Cart.new({"1":1, "2":2})
    package = cart.package ** need to make this method!




    EasyPostService.new(user, package)

    visit cart_path
  end


  scenario "when I checkout out with a valid shipping address" do


    expect(page).to have_content("Verify shipping address and continue")
    expect(page).to have_content("Shipping")
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content(user.address)
    expect(page).to have_content(user.address_2)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip)
    expect(page).to have_content(user.phone)


    click_on "Checkout"
    expect(current_path).to be('')
    # I see a new screen that asks me if this is the address I want to use
    # I can approve the address
    # my shipping cost is also added to my order total in a new total
    # I can click the button to place my order: sends to new_order_path
    # I see a screen with my order and an option to pay

  end

  describe "when I checkout out with an edited shipping address" do
    # I have an order in my cart
    # I click the checkout button
    # I see a new screen that asks me if this is the address I want to use
    # I can edit the address or approve the address
    # I can edit the address
    # I see a new screen with my address to edit
    # the screen has a button or link that takes me back to the screen where I approve the address
    # then I see a new screen with my shipping cost
  end

  describe "when I checkout out with an invalid shipping address" do
    # I have an order in my cart
    # I click the checkout button
    # I see a new screen that asks me if this is the address I want to use
    # I can approve the address
    # I am taken to the edit-addres screen with a flash message that says the address was invalid
  end

end








The shipment post that gives me back a rate.
https://api.easypost.com/v2

.post
conn.post("/shipments?", shipping_rate_params)

shipping_rate_url =

def shipping_rate_params(user, package)  package is a set of dimensions that increases with # of items.
  {

  


  =end
