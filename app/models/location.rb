class Location < ApplicationRecord
  attr_accessor :weather
  validates :api_id, :name, :country,
            presence: true

  self.per_page = 10

  has_many :follows
  has_many :users, through: :follows
end
