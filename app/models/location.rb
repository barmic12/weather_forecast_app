class Location < ApplicationRecord
  validates :api_id, :name, :country,
            presence: true
end
