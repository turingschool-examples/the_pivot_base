require 'rails_helper'

describe AdminAnalyticsPresenter do

  before do
    user = create(:user)
    store = create(:store)
    items = create_list(:item, 5, store: store)
    order_1 = create(:order, user: user)
    order_2 = create(:order, user: user)
    order_3 = create(:order, status: 0)
    order_4 = create(:order, status: 2)
    order_5 = create(:order, status: 3)

    order_item_1 = create(:order_item, store: store, order: order_1, item: items[0],  unit_price: items[0].price)
    order_item_1 = create(:order_item, store: store, order: order_2, item: items[1],  unit_price: items[1].price)
    order_item_1 = create(:order_item, store: store, order: order_3, item: items[2],  unit_price: items[2].price)
    order_item_1 = create(:order_item, store: store, order: order_4, item: items[3],  unit_price: items[3].price)
    order_item_1 = create(:order_item, store: store, order: order_5, item: items[4],  unit_price: items[4].price)
    AdminAnalyticsPresenter.new

  end

  describe '#total_sales' do
    it 'returns the total sales from an order' do
      expect(analytics.total_sales).to eq 40.0
    end
  end

  describe '#average_quantity_purchased' do
    it 'returns the average quantity purchased for an order item' do
      expect(analytics.average_quantity_purchased).to eq 2
    end
  end

  describe '#completed_orders' do
    it 'returns the count of completed orders for an order' do
      expect(analytics.completed_orders).to eq 2
    end
  end

  describe '#sales_by_item_title' do
    it 'returns total sales by item title' do
      expect(analytics.sales_by_item_title).to eq({"Book 2"=>3, "Book 1"=>1})
    end
  end

  describe '#status_for_items' do
    it 'returns status for items by name' do
      expect(analytics.status_for_items).to eq({["Book 2", 3]=>1, ["Book 1", 3]=>2})
    end
  end

  describe '#orders_per_customer' do
    it 'returns user orders' do
      expect(analytics.orders_per_customer).to eq({"customer10000@example.com"=>2})
    end
  end

  describe '#items_ordered_per_customer' do
    it 'returns quanity of items order by customer' do
      expect(analytics.items_ordered_per_customer).to eq({"customer10000@example.com"=>4})
    end
  end
end
