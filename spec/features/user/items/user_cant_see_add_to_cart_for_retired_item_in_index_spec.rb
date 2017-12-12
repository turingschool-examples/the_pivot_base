require 'rails_helper'

RSpec.describe 'As a visitor' do
	describe 'when visiting an items show page' do
		it 'a user cannot see add to cart for a retired item' do
			create(:item, category: create(:category))

			visit items_path

			expect(page).not_to have_content("Add to cart")
		end
	end
end