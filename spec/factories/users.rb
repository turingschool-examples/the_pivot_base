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
    email { Faker::Internet.email }
  end

  factory :platform_admin, class: User do
    first_name { Faker::Hipster.name }
    last_name  { Faker::AquaTeenHungerForce.character }
    password   { Faker::SiliconValley.company }
    email      { Faker::SiliconValley.app }
  end
end
