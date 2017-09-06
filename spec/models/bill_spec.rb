require 'rails_helper'

RSpec.describe Bill, type: :model do
  subject { build(:bill) }

  describe 'Model from Factory' do
    it { is_expected.to be_valid }

    context 'when any of the required fields is nil' do
      it { expect(build(:bill, amount: nil)).not_to be_valid }
      it { expect(build(:bill, title: nil)).not_to be_valid }
      it { expect(build(:bill, creator: nil)).not_to be_valid }
    end
  end

  describe 'Validators' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:creator) }
  end

  describe 'Active model associations' do
    it { is_expected.to belong_to(:creator) }
    it { is_expected.to have_many(:splits) }
    it { is_expected.to have_many(:payers).through(:splits) }
  end

  describe 'ActiveModel Callbacks' do
    it { is_expected.to callback(:sanitize_splitters).before(:save) }
    it { is_expected.to callback(:split_bill).after(:save) }
  end
end
