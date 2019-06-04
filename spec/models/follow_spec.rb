# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  it 'has valid factory' do
    expect(build(:follow)).to be_valid
  end

  let(:follow) { build(:follow) }

  describe 'ActiveModel validations' do
    it { expect(follow).to belong_to(:user) }
    it { expect(follow).to belong_to(:location) }
    it { expect(follow).to validate_uniqueness_of(:location_id).scoped_to(:user_id) }
  end
end
