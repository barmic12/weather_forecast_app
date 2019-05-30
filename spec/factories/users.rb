# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { 'password' }
    password_confirmation { 'password' }
    trait :invalid do
      email { nil }
    end
  end
end
