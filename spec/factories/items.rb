FactoryBot.define do
  factory :item do
    # May have to deal with: TBD
    # Faker::Name.unique.clear # Clears used values for Faker::Name
    #Faker::UniqueGenerator.clear # Clears used values for all generators
    title { Faker::Hipster.unique.word }
    description "Dead dove. Do not eat."
    price 10.00
    category
    store
  end
end
