FactoryBot.define do
  factory :location do
    api_id { Faker::Number.number }
    name { Faker::Address.city }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
