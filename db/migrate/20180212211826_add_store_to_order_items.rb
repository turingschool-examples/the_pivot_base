class AddStoreToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :store, foreign_key: true
  end
end
