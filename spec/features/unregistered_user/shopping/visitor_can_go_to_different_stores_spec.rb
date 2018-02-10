require "rails_helper"

describe "Visitor can see many stores" do

  #set up: 3 stores with a few items each

    xit "by clicking to changing url" do
      visit root_path
      click_on FIRST LINK TO SHOP NAME
      expect(page).to have_content(SOME-ITEM-NAME)

      visit "/#{store_2.slug}" #or store_path(store_1)
      expect(page).to have_content(SOME-ITEM-NAME)

      visit "/#{store_3.slug}"
      expect(page).to have_content(SOME-ITEM-NAME)
    end

    xit "and is returned to root if shop name is invalid" do
      visit root_path

      visit "/i-promise-there-is-no-store-with-this-name"

      expect(current_path).to be(root_path)
    end


end
