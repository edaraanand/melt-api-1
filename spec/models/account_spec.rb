require 'rails_helper'

describe Account do
  it { should belong_to(:user) }

  it 'should have a randomized id' do
    account_1 = Account.create
    account_2 = Account.create

    expect(account_1.id).not_to eq 1
    expect(account_2.id).not_to eq 2
  end
end
