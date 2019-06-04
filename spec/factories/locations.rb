# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    api_id { Faker::Number.number(2) }
    name { Faker::Address.city }
    country { Faker::Address.country_code }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
