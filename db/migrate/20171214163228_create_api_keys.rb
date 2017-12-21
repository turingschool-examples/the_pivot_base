class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
