FactoryBot.define do
  factory :item do
    sequence(:title) {|n| "Item #{n}" }
    description "Dead dove. Do not eat."
    price 10.00
    image File.open("./spec/support/images/test_image.jpg")
		store_id 1 
    category
  end
end


