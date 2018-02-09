


require 'rails_helper'
describe "As a visitor can visit category show page" do
    xit " can visit category show page" do
      category = create(:category, title: "cats")
        item_one = create(:item, category: category)
        item_two = create(:item, category: category)

        visit '/cats'

    end
end
