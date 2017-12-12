FactoryBot.define do
  factory :user do
    first_name "Gob"
    last_name  "Bluth"
    password   "password"
    email { Faker::Internet.email }
  end

  factory :admin, class: User do
    first_name "Gob"
    last_name  "Bluth"
    password   "password"
    role       "admin"
    email { Faker::Internet.email }
  end
end