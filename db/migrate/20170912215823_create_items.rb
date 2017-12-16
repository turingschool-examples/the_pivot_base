class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :image
      t.integer :status, default: 0
      t.references :category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
