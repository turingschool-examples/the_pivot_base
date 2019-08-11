class DropStoreItems < ActiveRecord::Migration[5.1]
  def change
    drop_table :store_items
  end
end
