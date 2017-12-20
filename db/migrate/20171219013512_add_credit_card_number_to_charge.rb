class AddCreditCardNumberToCharge < ActiveRecord::Migration[5.1]
  def change
    add_column :charges, :credit_card_number, :string
  end
end
