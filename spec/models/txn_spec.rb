require 'rails_helper'

RSpec.describe Txn, type: :model do
  subject { build_stubbed(:txn) }

  context 'validations' do
    context 'failure' do
      it { subject.amount = 'a' }
      it { subject.amount = 0 }
      it { subject.amount = -2 }
      it { subject.amount = 2 }
      it { subject.amount = '-2' }
      it { subject.amount = '+2' }

      after { expect(subject).to_not be_valid }
    end

    context 'successful' do
      it { subject.amount = -1 }
      it { subject.amount = 1 }
      it { subject.amount = '+1' }
      it { subject.amount = '-1' }

      after { expect(subject).to be_valid }
    end
  end

  context 'relations' do
    it { expect(subject.user).to be_kind_of(User) }
  end
end
