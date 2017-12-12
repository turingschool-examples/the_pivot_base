FactoryBot.define do
  factory :item do
    title { Faker::Hipster.word }
    description "Dead dove. Do not eat."
    price 10.00
    category

    # image_file_name "test_image.jpg"
    # image_content_type "image/jpeg"
    # image_file_size 346843
  end
end