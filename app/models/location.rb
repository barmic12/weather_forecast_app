# frozen_string_literal: true

class Location < ApplicationRecord
  attr_accessor :weather
  validates :api_id, :name, :country,
            presence: true

  self.per_page = 10

  has_many :follows
  has_many :users, through: :follows

  scope :not_subscribed_by_user, ->(query, user) {
                                  where.not(id: Follow.select(:location_id).where(user_id: user ))
                                       .where('lower(locations.name) LIKE ?', "#{query.try(:downcase)}%") }
  def belongs_to_user?(user)
    Follow.find_by(location: self, user: user).present?
  end
end
