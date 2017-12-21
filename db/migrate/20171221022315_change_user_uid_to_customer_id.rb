class ChangeUserUidToCustomerId < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :uid
    add_column :users, :customer_id, :string
  end
end
