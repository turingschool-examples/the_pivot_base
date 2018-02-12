FactoryBot.define do


  factory :user, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
    store
  end

  factory :registered_user, class: User do #change to registered_user
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
    store
  end

  factory :store_manager, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
    store
  end


  factory :store_admin, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
  end

  factory :platform_admin, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
  end

end
