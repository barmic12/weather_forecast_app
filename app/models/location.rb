class Location < ApplicationRecord
  validates :api_id, :name, :country,
            presence: true

  self.per_page = 10
end
