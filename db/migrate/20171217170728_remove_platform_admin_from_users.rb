class RemovePlatformAdminFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :platform_admin, :boolean
  end
end
