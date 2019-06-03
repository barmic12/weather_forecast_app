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
end
