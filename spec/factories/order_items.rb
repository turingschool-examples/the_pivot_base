FactoryBot.define do
  factory :order_item do
    item
    order
    store
    quantity 1
    unit_price 5.00
  end
end
