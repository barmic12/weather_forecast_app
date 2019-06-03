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
end
