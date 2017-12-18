class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.string :uid
      t.references :order, foreign_key: true, index: true

      t.timestamps
    end
  end
end
