FactoryBot.define do
  factory :order_item do
    item
    order
    quantity 1
    price 5.00
  end
end
