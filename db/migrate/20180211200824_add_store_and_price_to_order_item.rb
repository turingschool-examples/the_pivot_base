class AddStoreAndPriceToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :store, index: true
    #price was already added, so I just left the migration as is but removed that line. 
  end
end
