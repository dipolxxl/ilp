require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET 'index'" do

    context 'for empty DB' do
      before do
        allow(User).to receive_message_chain(:select, :order) { [] }
        get :index
      end

      it { expect(response).to be_success }
      it { expect(response.body).to eq({ users: [] }.to_json) }
    end

    context 'for filled DB' do
      before(:all) { create(:user, name: 'Test user') }
      before { get :index }

      it { expect(response).to be_success }

      it 'return users array (in json format)' do
        expect(response.body)
          .to eq({ users: [{name: 'Test user', balance: 0}] }.to_json)
      end
    end
  end
end
