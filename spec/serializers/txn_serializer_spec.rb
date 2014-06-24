require 'rails_helper'

RSpec.describe TxnSerializer do
  let(:user) { build_stubbed(:user) }
  let(:txn)  { build_stubbed(:txn, user: user) }
  let(:serialized_txn) { TxnSerializer.new(txn).serializable_hash }

  subject { serialized_txn }

  it { expect(subject[:id]).to eq txn.id }
  it { expect(subject[:amount]).to eq txn.amount }
  it { expect(subject[:created_at]).to eq txn.created_at }

  it do
    expect(subject.to_json).to eq(
      {
        id: txn.id,
        amount: txn.amount,
        created_at: txn.created_at
      }.to_json
    )
  end
end
