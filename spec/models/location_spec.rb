# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'has valid factory' do
    expect(build(:location)).to be_valid
  end

  let(:location) { build(:location) }

  describe 'ActiveModel validations' do
    it { expect(location).to validate_presence_of(:api_id) }
    it { expect(location).to validate_presence_of(:name) }
    it { expect(location).to validate_presence_of(:country) }
  end

  describe 'ActiveRecord associations' do
    it { expect(location).to have_many(:users).through(:follows) }
  end

  describe 'Methods' do
    describe 'belongs_to_user?(user)' do
      let(:user) { create(:user) }
      it 'returns true if belongs to user' do
        create(:follow, location: location, user: user)
        expect(location.belongs_to_user?(user)).to be true
      end

      it 'returns false if not belongs to user' do
        different_user = create(:user)
        create(:follow, location: location, user: user)
        expect(location.belongs_to_user?(different_user)).to be false
      end
    end
  end

  describe 'Scopes' do
    describe 'not_subscribed_by_user' do
      let(:user) { create(:user) }
      it 'returns 1 location' do
        location1 = create(:location)
        location2 = create(:location)
        create(:follow, location: location1, user: user)
        expect(Location.not_subscribed_by_user(nil, user).length).to eq(1)
      end
    end
  end
end
