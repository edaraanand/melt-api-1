require 'rails_helper'

describe Account do
  it { should have_many(:users) }
  it { should have_many(:addresses) }

  it 'should have a randomized id' do
    account_1 = Account.create
    account_2 = Account.create

    expect(account_1.id).not_to eq 1
    expect(account_2.id).not_to eq 2
  end

  it 'should have a test_api_key' do
    account = Account.create

    expect(account.test_api_key).not_to be_nil
  end
end
