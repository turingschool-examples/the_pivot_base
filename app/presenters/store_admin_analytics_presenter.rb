class StoreAdminAnalyticsPresenter

  def initialize(store)
    @store = store
  end

  def total_sales
    @store.orders.shop_total_gross
  end

  def average_quantity_purchased
    @store.order_items.average_quantity
  end

  def completed_orders
    @store.orders.count_of_completed_orders
  end

  def sales_by_item_title
    @store.items.total_sold_by_item
  end

  def status_for_items
    @store.items.items_by_title_with_status
  end

end
