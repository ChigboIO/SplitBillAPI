require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Model from Factory' do
    it { is_expected.to be_valid }

    context 'when any of the required fields is nil' do
      it { expect(build(:user, email: nil)).not_to be_valid }
      it { expect(build(:user, username: nil)).not_to be_valid }
      it { expect(build(:user, name: nil)).not_to be_valid }
    end

    context 'when any unique field is already in use' do
      let(:existing_user) { create(:user) }
      it { expect(build(:user, email: existing_user.email)).not_to be_valid }
      it { expect(build(:user, username: existing_user.username)).not_to be_valid }
    end
  end

  describe 'Validators' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe 'Active model associations' do
    it { is_expected.to have_many(:tokens) }
    it { is_expected.to have_many(:bills) }
    it { is_expected.to have_many(:splits) }
  end
end
