require 'rails_helper'

describe 'A user visits the customer support channel' do
  context 'registered user' do
    it 'they can send a message' do
      Chatroom.create(topic: "Customer Support")
      user = User.create(first_name: "dude", last_name: "guy", email: "dude@guy.com", password: "password")
      stub_logged_in_user(user)

      visit "/chatrooms/customer-support"

      expect(page).to have_content("Customer Support")
      expect(page).to have_content("Your message:")
      expect(page).to have_button("send")

      fill_in "message[content]", with: "THIS IS SUPER COOL!"
      click_on("send")

      expect(page).to have_content("THIS IS SUPER COOL!")
    end
  end

  context 'A visitor visits /chatrooms/customer-support' do
    it 'they see a 404' do
      visit "/chatrooms/customer-support"

      expect(page).to have_content("404")
    end
  end
end
