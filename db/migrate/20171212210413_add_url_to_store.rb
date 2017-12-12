class AddUrlToStore < ActiveRecord::Migration[5.1]
  def change
		add_column :stores, :url, :string
  end
end
