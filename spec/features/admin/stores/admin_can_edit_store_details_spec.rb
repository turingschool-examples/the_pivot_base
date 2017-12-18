require 'rails_helper'

feature "an admin can update store info" do
  let(:admin) { create(:store_admin) }
  let(:store) { admin.stores.first }

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(admin)
    visit admin_store_path(store.url)
    click_on('Update Store Information')
  end

  it "they see a form to edit the store" do
    expect(current_path).to eq(admin_edit_store_path(store.url))
  end

  context "they fill out the form and click submit" do
    before do
      fill_in 'store[name]', with: 'Banana Stand'
      select('Active', :from => 'status')
      click_on("Update Business")
    end

    it 'they are taken back to the admin store show' do
      expect(page).to have_current_path(admin_store_path(store.url))
    end

    xit 'they see a success message' do
      expect(find('.alert-success'))
      .to have_content('Successfully updated something unique')
    end

    xit 'they see the updated information' do
      expect(page).to have_content('something unique')
      expect(page).to have_content('something descriptive')
      expect(page).to have_content('$79.99')
    end

  end
end
