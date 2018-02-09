require 'rails_helper'

describe "Platform Admin can visit any page" do

  xit "they visit registered user pages" do

    /store
    /store/category
    /store/category/items
    /store/item

  end


  xit "they visit business manager pages" do

    /store/manager/dashboard
    /store/manager/category
    /store/manager/category/items
    /store/manager/order
    /store/manager/item

  end


  xit "they visit business admin pages" do

    /store/admin/dashboard
    /store/admin/dashboard/managers
    /store/admin/category
    /store/admin/category/items
    /store/admin/order
    /store/admin/item

  end


end
