# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations feature', type: :feature do
  let(:user) { create(:user) }
  let(:city) { Faker::Address.city }
  feature 'Visitor find city' do
    before do
      create(:location, name: city)
    end
    scenario 'as logged user' do
      log_in
      visit '/locations'
      fill_in :query, with: city[0,2]
      click_button(I18n.t('locations.index.search'))
      expect(page).to have_css('td', text: city)
    end
  end

  feature 'Visitor add location to following' do
    before do
      location = create(:location)
      stub_current_weather(location)
    end
    scenario 'as logged user' do
      log_in
      visit '/locations'
      first('tr > td > span').click_link('Follow')
      expect(body).to have_css('div.alert-success', text: I18n.t('locations.follow.success'))
    end
  end
end
