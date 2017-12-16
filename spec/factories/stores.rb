FactoryBot.define do
  factory :store do
    sequence(:name) {|n| "MyString#{n}" }
    status 1


  factory :store_with_items, class: Store do
    after(:create) do |store|
        item     = create(:item)
        store.items << item
      end
    end
  end
end
