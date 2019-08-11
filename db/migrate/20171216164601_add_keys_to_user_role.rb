class AddKeysToUserRole < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_roles, :user, index: true
    add_reference :user_roles, :role, index: true
  end
end
