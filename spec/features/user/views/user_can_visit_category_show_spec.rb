require 'rails_helper'
RSpec.describe "As a visitor can visit category show page" do
    it " can visit category show page" do
      category = create(:category, title: "cats")
        item_one = create(:item, category: category)
        item_two = create(:item, category: category)

        visit '/cats'

    end
end
