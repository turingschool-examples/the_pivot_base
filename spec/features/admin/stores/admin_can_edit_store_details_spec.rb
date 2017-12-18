require 'rails_helper'

feature "an admin can update store info" do
  let(:admin) { create(:platform_admin) }
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
      select('active', :from => 'status')
      click_on("Update Business")
      @store = admin.stores.first
    end

    it 'they are taken back to the admin store show' do
      expect(page).to have_current_path(admin_store_path(@store.url))
    end

    it 'they see a success message' do
      expect(page).to have_content("#{@store.name} successfully updated")
    end

    it 'they see the updated information' do
      expect(page).to have_content("#{@store.name}")
      expect(page).to have_content('Active')
    end

  end

  context 'only platform admin can update status' do
    it 'store admin do not see status dropdown' do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(create(:store_admin))
      visit admin_store_path(store.url)
      click_on('Update Store Information')

      assert has_no_field?('status')
    end
  end

end
