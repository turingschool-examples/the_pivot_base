class AddStoreToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :store, foreign_key: true
  end
end
