class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :status, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
