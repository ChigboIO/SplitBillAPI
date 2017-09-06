require 'rails_helper'

RSpec.describe Split, type: :model do
  subject { build(:split) }

  describe 'Model from Factory' do
    it { is_expected.to be_valid }

    context 'when any of the required fields is nil' do
      it { expect(build(:split, amount: nil)).not_to be_valid }
      it { expect(build(:split, bill: nil)).not_to be_valid }
      it { expect(build(:split, payer: nil)).not_to be_valid }
    end
  end

  describe 'Validators' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:bill) }
    it { is_expected.to validate_presence_of(:payer) }
  end

  describe 'Active model associations' do
    it { is_expected.to belong_to(:payer) }
    it { is_expected.to belong_to(:bill) }
  end
end
