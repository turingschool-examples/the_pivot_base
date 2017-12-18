FactoryBot.define do
  factory :store do
    sequence(:name) {|n| "MyString#{n}" }
    status 1


  factory :store_with_items, class: Store do
    after(:create) do |store|
        item     = create_list(:item, 4)
        store.items << item
      end
    end

    factory :store_with_item, class: Store do
      after(:create) do |store|
          item     = create(:item)
          store.items << item
        end
      end

      factory :store_with_order, class: Store do
        after(:create) do |store|
            order     = create(:order_with_items)
            store.orders << order
          end
        end
  end
end
