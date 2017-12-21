class CreateUserRoleStores < ActiveRecord::Migration[5.1]
  def change
    create_table :user_role_stores do |t|
      t.references :user, foreign_key: true, index: true
      t.references :role, foreign_key: true, index: true
      t.references :store, foreign_key: true, index: true

      t.timestamps
    end
  end
end
