require 'rails_helper'
RSpec.describe SessionsHelper, type: :helper do
  describe '#account_navigation' do
    context 'for logged user' do
      let(:current_user) { create(:user) }
      it 'returns link to logout page' do
        expected_link = link_to t('sessions.form.logout'), logout_path, class: 'nav-link', method: :delete
        expect(account_navigation).to eq(expected_link)
      end
    end

    context 'for unlogged user' do
      let(:current_user) { nil }
      it 'returns link to login page' do
        expected_link = link_to I18n.t('sessions.form.sign_in_or_sign_up'), '/login', class: 'nav-link'
        expect(account_navigation).to eq(expected_link)
      end
    end
  end
end
