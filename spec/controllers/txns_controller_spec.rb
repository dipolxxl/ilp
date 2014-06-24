require 'rails_helper'

RSpec.describe TxnsController, type: :controller do

  describe "GET 'index'" do
    let(:user) { build_stubbed(:user) }

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
end
