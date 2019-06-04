class Location < ApplicationRecord
  attr_accessor :weather
  validates :api_id, :name, :country,
            presence: true

  self.per_page = 10

  has_many :follows
  has_many :users, through: :follows

  def belongs_to_user?(user)
    Follow.find_by(location: self, user: user).present?
  end
end
