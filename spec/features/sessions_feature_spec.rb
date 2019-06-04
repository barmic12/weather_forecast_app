# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions feature', type: :feature do
  let(:user) { create(:user) }
  feature 'Visitor log in' do
    scenario 'with correct params' do
      log_in_with(user.email, user.password)
      expect(body).to have_css('div.alert-success')
      expect(current_path).to eq(root_path)
    end

    scenario 'with incorrect params' do
      invalid_password = "wrong#{user.password}"
      log_in_with(user.email, invalid_password)
      expect(body).to have_css('div.alert-danger')
      expect(current_path).to eq(login_path)
    end
  end

  feature 'Visitor log out' do
    scenario 'clicks on logout link' do
      log_in_with(user.email, user.password)
      log_out
      expect(body).to have_css('div.alert-success')
      expect(body).to have_link(href: '/login')
    end
  end

  def log_in_with(email, password)
    visit '/login'
    fill_in :session_email, with: email
    fill_in :session_password, with: password
    click_button I18n.t('sessions.form.create')
  end

  def log_out
    click_link(I18n.t('sessions.form.logout'))
  end
end
