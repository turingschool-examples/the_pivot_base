class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :slug, :url
    rename_column :items, :status, :status
  end
end
