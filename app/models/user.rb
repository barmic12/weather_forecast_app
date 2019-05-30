# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :username, presence: true, uniqueness: true

  validates :password, presence: true, on: :create
  validates :password, confirmation: { case_sensitive: true }
  validates :password, length: { minimum: 8 }, allow_blank: true
end
