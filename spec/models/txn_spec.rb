require 'rails_helper'

RSpec.describe Txn, type: :model do
  subject { build_stubbed(:txn) }

  context 'validations' do
    context 'failure' do
      it { subject.amount = 'a' }
      it { subject.amount = 0 }

      after { expect(subject).to_not be_valid }
    end

    context 'successful' do
      it { subject.amount = -10 }
      it { subject.amount = 100 }

      after { expect(subject).to be_valid }
    end
  end

  context 'relations' do
    it { expect(subject.user).to be_kind_of(User) }
  end

  context 'scopes' do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:txn_1)  { create(:txn, user: user_1) }
    let(:txn_2) { create(:txn, user: user_2) }
    let(:txn_3) { create(:txn, user: user_1) }

    it { expect(Txn.for_user(user_1)).to eq([txn_1, txn_3]) }
  end
end
