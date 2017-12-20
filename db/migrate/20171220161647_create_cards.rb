class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true, index: true
      t.string :uid

      t.timestamps
    end
  end
end
