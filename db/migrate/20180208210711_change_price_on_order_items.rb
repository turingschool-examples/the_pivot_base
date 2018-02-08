class ChangePriceOnOrderItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_items, :price, :unit_price
  end
end
