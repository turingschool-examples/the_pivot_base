FactoryBot.define do
  factory :store do
    sequence(:name) {|n| "MyString#{n}" }
    status 1
  end
end
