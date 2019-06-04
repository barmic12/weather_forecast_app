# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations feature', type: :feature do
  feature 'Visitor signs up' do
    scenario 'with valid email, username and password' do
      signs_up_with('user@example.com', 'user', 'password', 'password')
      expect(current_path).to eq(root_path)
    end

    scenario 'with blank email' do
      signs_up_with(nil, 'user', 'password', 'password')
      expect(page).to have_selector('#form-errors')
    end

    scenario 'with invalid email' do
      signs_up_with('invalid.email', 'user', 'password', 'password')
      expect(page).to have_selector('#form-errors')
    end

    scenario 'with blank username' do
      signs_up_with('user@example.com', nil, 'password', 'password')
      expect(page).to have_selector('#form-errors')
    end

    scenario 'with blank passwords' do
      signs_up_with('user@example.com', 'user', nil, nil)
      expect(page).to have_selector('#form-errors')
    end

    scenario 'with two different passwords' do
      signs_up_with('user@example.com', 'user', 'password', 'diff_pass')
      expect(page).to have_selector('#form-errors')
    end

    def signs_up_with(email, username, password, password_confirmation)
      visit new_registration_path
      fill_in :user_email, with: email
      fill_in :user_username, with: username
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation
      click_button I18n.t('registrations.form.create')
    end
  end
end
