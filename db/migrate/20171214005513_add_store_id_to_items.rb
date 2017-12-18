class AddStoreIdToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :store, index: true
  end
end
