FactoryBot.define do
  factory :user do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }

    factory :store_admin, class: User do
      after(:create) do |user|
        role = create(:role, name: "store_admin")
        store = create(:store)
        create(:store_user, user: user, role: role, store: store)
      end
    end

    factory :store_admin_with_store_items, class: User do
      after(:create) do |user|
        role = create(:role, name: "store_admin")
        store = create(:store_with_items)
        create(:store_user, user: user, role: role, store: store)
      end
    end

    factory :platform_admin, class: User do
      after(:create) do |user|
        role = create(:role, name: "platform_admin")
        store = create(:store)
        create(:store_user, user: user, role: role, store: store)
      end
    end

    factory :store_manager, class: User do
      after(:create) do |user|
        role = create(:role, name: "store_manager")
        store = create(:store)
        create(:store_user, user: user, role: role, store: store)
      end
    end

    factory :default_user, class: User do
      after(:create) do |user|
        role = create(:role, name: "default")
        store = create(:store)
        create(:store_user, user: user, role: role, store: store)
      end
    end

  end
end
