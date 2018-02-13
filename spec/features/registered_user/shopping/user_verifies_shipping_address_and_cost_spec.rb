require 'rails_helper'

feature "As an authenticated user" do
  describe "when I checkout out with a valid shipping address" do

    user = User.new()
    # I have an order in my cart
    # I click the checkout button
    # I see a new screen that asks me if this is the address I want to use
    # I can approve the address
    # my shipping cost is also added to my order total in a new total
    # I can click the button to place my order
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
