FactoryBot.define do


  factory :user do #change to registered_user
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
    store

  end

  factory :business_manager, class: User do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
    store
  end

  factory :admin, class: User do  #change to business_admin
    first_name "Gob"
    last_name "Bluth"
    password "password"
    role "admin"
    sequence(:email) {|n| "admin-#{n}@example.com" }
  end

  factory :business_admin, class: User do
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
