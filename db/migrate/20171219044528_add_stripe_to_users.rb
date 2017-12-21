class AddStripeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_token, :string
    add_column :users, :stripe_id, :string
  end
end
