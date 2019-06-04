# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :location_id, uniqueness: { scope: :user_id }
end
