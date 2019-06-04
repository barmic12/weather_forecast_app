# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'ActiveModel validations' do
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }
    it { expect(user).to validate_presence_of(:username) }
    it { expect(user).to validate_uniqueness_of(:username) }
    it { expect(user).to validate_length_of(:password).is_at_least(8) }

    # https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/active_model/validate_presence_of_matcher.rb#L26
    #it { expect(user).to validate_presence_of(:password) }
  end

  describe 'Destroy user' do
    it 'destroys belonging follows' do
      user = create(:user)
      create(:follow, user: user)
      expect { user.destroy }.to change { Follow.count }.by(-1)
    end
  end

  describe 'ActiveRecord associations' do
    it { expect(user).to have_many(:locations).through(:follows) }
  end
end
