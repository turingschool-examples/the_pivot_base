require 'rails_helper'

describe "Platform Admin can visit any page" do
  before(:each) do
    god = create(:platform_admin)
    role = create(:role, title: "platform_admin")
    user_role = create(:user_role, user: god, role: role)
    @store = create(:store)
    @category = create(:category)
    @item = create(:item, store: @store, category: @category)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(god)

  end

  it "they visit registered user pages" do
    visit "/#{@store.slug}/items"
    expect(current_path).to eq store_items_path(@store)
    expect(page).to have_content(@item.title)

    visit "/#{@category.slug}"
    expect(current_path).to eq category_path(@category)
    expect(page).to have_content(@item.title)

    visit "/#{@store.slug}/items/#{@item.id}"
    expect(current_path).to eq store_item_path(@store, @item)
    expect(page).to have_content(@item.title)
    expect(page).to have_content(@item.description)
  end

  it "they visit business manager pages" do
    visit "/admin/#{@store.slug}/items"
    expect(current_path).to eq admin_store_items_path(@store)
    expect(page).to have_content("#{@item.title}")
    expect(page).to have_link("Edit")

    visit "/admin/#{@store.slug}/items/#{@item.id}/edit"

    expect(current_path).to eq edit_admin_store_item_path(@store, @item)
    expect(page).to have_content("Edit Item")
    expect(page).to have_css(".form-control")
    expect(page).to have_button("Submit")

  end
end
