class AddIndexToCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :credit_cards, :users, foreign_key: true
  end
end
