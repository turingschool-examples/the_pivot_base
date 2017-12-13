require 'rails_helper'
RSpec.describe "As a visitor can visit category show page" do
    it " can visit category show page" do
        category = create(:category, title: 'Cats')

        create(:item, category_id: category.id)
        
        visit '/cats'
        
    end
end