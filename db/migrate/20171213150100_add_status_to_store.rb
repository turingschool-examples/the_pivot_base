class AddStatusToStore < ActiveRecord::Migration[5.1]
  def change
		add_column :stores, :status, :string, default: "Pending"
  end
end
