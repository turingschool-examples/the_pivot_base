FactoryBot.define do
  factory :user do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
  end
end  

  #   trait :role do
  #     name
  #   end
  # end
  #
  # factory :user do
  #   association :store_admin, factory: [:role, :user], name:'store_admin'
  # end



  #
  # factory :admin, class: User do
  #   first_name "Gob"
  #   last_name "Bluth"
  #   password "password"
  #   sequence(:email) {|n| "admin-#{n}@example.com" }
  # end
