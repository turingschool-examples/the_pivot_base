class AddConditonToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :status, :integer, default: 0
  end
end
