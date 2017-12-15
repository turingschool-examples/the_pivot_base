class RenameUserRolesToStoreUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_roles, :store_users
  end
end
