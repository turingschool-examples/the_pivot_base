class AddColumnToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :url, :string
    add_column :items, :url, :string
  end
end
