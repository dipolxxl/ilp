require 'rails_helper'

RSpec.describe TxnManager do
  let(:user) { create(:user) }
  let(:txn) { build(:txn, user: user ) }
  let(:valid_params) { { amount: 1, user_id: user.id } }
  let(:invalid_params) { { amount: 'wrong', user_id: user.id } }

  def txn_save(params)
    TxnManager.new(params).save
  end

  describe "#save" do
    context 'failure' do
      it 'for invalid amount value' do
        expect(txn_save invalid_params).to eq(:unprocessable_entity)
      end
    end

    context 'successful' do
      it 'for valid amount value' do
        expect(txn_save valid_params).to eq(:created)
      end

      context 'must call required methods' do
        before do
          allow(User).to receive(:find).and_return(user)
          allow(Txn).to receive(:new).and_return(txn)
        end

        it { expect(Txn).to receive(:transaction) }
        it { expect(txn).to receive(:save!) }
        it { expect(user).to receive(:save!) }

        after { txn_save valid_params }
      end
    end
  end
end
