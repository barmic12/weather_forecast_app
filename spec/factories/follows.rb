# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    user
    location
  end
end
