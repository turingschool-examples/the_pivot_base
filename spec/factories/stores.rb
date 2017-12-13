FactoryBot.define do
  factory :store do
    sequence :name do |x|
      "#{x}MyStore"
    end

    sequence :slug do |y|
      "#{y}-my-store"
    end
    status 0
  end
end
