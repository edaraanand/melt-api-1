require 'rails_helper'

describe User do
  it { should belong_to(:account) }

  it 'should have a randomized id' do
    user_1 = User.create
    user_2 = User.create

    expect(user_1.id).not_to eq 1
    expect(user_2.id).not_to eq 2
  end

  it 'should have an account created upon registration' do
    subject = create(:user)

    expect(subject.account).not_to be nil
  end
end
