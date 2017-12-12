require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe 'realtionships' do
    it { should belong_to(:user) }
    it { should respond_to(:user) }
    it { should have_many(:items) }
    it { should respond_to(:items) }
  end

  describe "instance methods" do
    it "can return total price of items" do
      gob = create(:user)
      order = create(:order, status: "ordered", user: gob)
      category = create(:category)
      item_1 = create(:item, title: "Dove", price: 10.00)
      item_2 = create(:item, title: "Seal", price: 1.00)
      item_not_included = create(:item, title: "Banana Stand", price: 100.00)
      order_item1 = create(:order_item, order: order, item: item_1)
      order_item2 = create(:order_item, order: order, item: item_2)

      order.items << item_1
      order.items << item_2

      expect(order.total_price).to eq(11.0)
    end

    it "can add an item" do
      user = User.create!(first_name: "Testy",
                          last_name: "McTest",
                          password: "testing",
                          email: "tester@testmail")

      order     = user.orders.create!(status: "ordered")
      category  = create(:category)
      item      =  create(:item)
      item_hash = {item => 1}

      expect(order.items).to eq([])

      order.add(item_hash)

      expect(order.items.first).to eq(item)
    end

    it "can return the order date" do
      order = create(:order, created_at: "2017-09-13 01:13:04 -0600")

      expect(order.date).to eq("Sep. 13, 2017")
    end
  end

  describe "class methods" do
    it "can count by status" do
      create(:order, status: "ordered")
      create(:order, status: "ordered")
      create(:order, status: "paid")
      create(:order, status: "cancelled")

      status_count = {"paid"=>1, "ordered"=>2, "cancelled"=>1}

      expect(Order.count_by_status).to eq(status_count)
    end

  end
end
