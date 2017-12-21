class AddStuffToCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :card_number, :string
    add_column :credit_cards, :cvv, :string
    add_column :credit_cards, :exp_month, :string
    add_column :credit_cards, :exp_year, :string
  end
end
