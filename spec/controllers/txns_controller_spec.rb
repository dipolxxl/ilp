require 'rails_helper'
require 'active_support/core_ext/hash/indifferent_access'

RSpec.describe TxnsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET 'index'" do
    context 'for empty DB (user without transactions)' do
      before do
        allow(Txn).to receive_message_chain(:where, :order) { [] }
        get :index, user_id: user.id
      end

      it { expect(response).to be_success }
      it { expect(response.body).to eq({ txns: [] }.to_json) }
    end

    context 'for filled DB (user with transactions)' do
      before do
        @txn = create(:txn, amount: 1, user: user)
        get :index, user_id: user.id
      end

      it { expect(response).to be_success }

      it 'return txns array (in json format)' do
        expect(response.body).to eq(
          {
            txns: [
              {id: @txn.id, amount: @txn.amount, created_at: @txn.created_at}
            ]
          }.to_json
        )
      end
    end
  end

  describe "POST 'create'" do
    it 'returns :created for valid params' do
      post :create, user_id: user.id, txn: { amount: 1 }
      expect(response.status).to eq 201
    end

    it 'returns :unprocessable_entity for invalid params' do
      post :create, user_id: user.id, txn: { amount: 'error' }
      expect(response.status).to eq 422
    end

    it 'call methods of TxnManager' do
      # values in str format for hash comparing
      params = { amount: '1', user_id: user.id.to_s }.with_indifferent_access
      manager = TxnManager.new(params)

      # stubbing
      allow(TxnManager).to receive(:new).and_return(manager)
      allow(manager).to receive(:save).and_return(:created)

      expect(TxnManager).to receive(:new).with(params)
      post :create, user_id: user.id, txn: { amount: 1 }
    end
  end
end
