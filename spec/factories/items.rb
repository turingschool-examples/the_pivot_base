FactoryBot.define do
  factory :item do
    sequence(:title) {|n| "Item #{n}" }
    description "Dead dove. Do not eat."
    price 10.00
    image "book_cover.png"
    category
    store
  end
end
