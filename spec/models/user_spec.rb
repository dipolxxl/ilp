require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build_stubbed(:user) }

  context 'validations' do
    context 'failure' do
      it { subject.name = nil }
      it { subject.email = nil }
      it { subject.balance = nil }
      it { subject.name = 'a'*256 }
      it { subject.email = 'invalid@email' }
      it { subject.balance = -1 }

      after { expect(subject).to_not be_valid }
    end

    context 'successful' do
      it { subject.name = 'a'*5 }
      it { subject.email = 'valid@email.address' }
      it { subject.balance = 100 }

      after { expect(subject).to be_valid }
    end
  end

  context 'relations' do
    it { expect(subject.txns).to eq [] }
    it { expect(subject.txns.new).to be_kind_of(Txn) }
  end
end
