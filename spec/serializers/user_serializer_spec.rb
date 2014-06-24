require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { build_stubbed(:user) }
  let(:serialized_user) { UserSerializer.new(user).serializable_hash }

  subject { serialized_user }

  it { expect(subject[:name]).to eq user.name }
  it { expect(subject[:balance]).to eq user.balance }

  it do
    expect(subject.to_json)
      .to eq({name: user.name, balance: user.balance}.to_json)
  end
end
