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

  it "they fill out the form and click submit" do
    expect(current_path).to eq(admin_edit_store_path(store.url))
  end
end
