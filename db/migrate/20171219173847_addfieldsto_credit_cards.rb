class AddfieldstoCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :name, :string
    add_column :credit_cards, :city, :string
    add_column :credit_cards, :country, :string
    add_column :credit_cards, :address_one, :string
    add_column :credit_cards, :address_two, :string
    add_column :credit_cards, :state, :string
    add_column :credit_cards, :zip, :string
  end
end
