# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account Settings feature', type: :feature do
  let(:user) { create(:user) }
  feature 'Visitor removes his account' do
    scenario 'as logged user' do
      log_in
      remove_account
      expect(page).to have_css('div.alert-success', text: I18n.t('account_settings.index.remove_message'))
    end

    def remove_account
      visit '/account_settings'
      click_link(I18n.t('account_settings.index.remove'))
    end
  end
end
