require 'rails_helper'

RSpec.describe Token, type: :model do
  subject { build(:token) }

  describe 'Model from Factory' do
    it { is_expected.to be_valid }

    context 'when any of the required fields is nil' do
      it { expect(build(:token, value: nil)).not_to be_valid }
    end
  end

  describe 'Validators' do
    it { is_expected.to validate_presence_of(:value) }
  end

  describe 'Active model associations' do
    it { is_expected.to belong_to(:user) }
  end
end
