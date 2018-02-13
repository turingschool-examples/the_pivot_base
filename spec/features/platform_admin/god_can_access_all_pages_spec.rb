require 'rails_helper'

describe "Platform Admin can visit any page" do
  before(:each) do
    god = create(:platform_admin)
    role = create(:role, title: "platform_admin")
    user_role = create(:user_role, user: god, role: role)
    @store = create(:store)
    @item = create(:item, store: @store)
    @category = create(:category)
  end

  it "they visit registered user pages" do
    visit "/#{@store.slug}/items"
    expect(current_path).to eq store_items_path(@store)

    visit "/#{@category.slug}"
    expect(current_path).to eq category_path(@category)

    visit "/#{@store.slug}/items/#{@item.id}"
    expect(current_path).to eq store_item_path(@store, @item)
    expect(page).to have_content(@item.title)
  end

  it "they visit business manager pages" do
    visit "/admin/#{@store.slug}/items"
    expect(current_path).to eq admin_store_items_path(@store)
    expect(page).to have_content ("#{store.name}")

    # visit "/#{@category.slug}"
    # expect(current_path).to eq category_path(@category)
    #
    # visit "/#{@store.slug}/items/#{@item.id}"
    # expect(current_path).to eq store_item_path(@store, @item)
    # expect(page).to have_content(@item.title)
    # /store/manager/dashboard
    # /store/manager/category
    # /store/manager/category/items
    # /store/manager/order
    # /store/manager/item

  end


  xit "they visit business admin pages" do

    # /store/admin/dashboard
    # /store/admin/dashboard/managers
    # /store/admin/category
    # /store/admin/category/items
    # /store/admin/order
    # /store/admin/item

  end


end
