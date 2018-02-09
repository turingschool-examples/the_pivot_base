require 'rails_helper'

#this one is required by the instructors per the spec
describe "Registered User visits store" do

  # Background: There is an active company with a name of "Vandelay Industries" with 2 active items and 1 inactive item. There is also 1 item that isn't associated with this store.
  xit "they see items for that store and no other stores' items"
    # As a logged in user
    # When I visit "/vandelay-industries"
    # Then I should see a list of all active items for this store
    # And I should not see inactive items or items for other stores
  end

end
