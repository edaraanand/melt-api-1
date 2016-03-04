require 'rails_helper'

describe Api::V1::AddressesController do
  context '#index' do
    it 'sends a list of addresses associated to an account' do
      user = create(:user)
      user_account = user.account
      create_list(:address, 7, account_id: user_account.id)
      create_list(:address, 5, account_id: 123)

      add_token_to_header(user_account.test_api_key)

      get :index

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['addresses'].count).to eq(7)
    end
  end

  context '#show' do
    it 'sends data regarding a specific address associated to an account' do
      user = create(:user)
      user_account = user.account
      address = create(:address, account_id: user_account.id, id: 1)

      add_token_to_header(user_account.test_api_key)

      get :show, { id: 1 }

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['address']['id']).to          eq(1)
      expect(json['address']['description']).to eq(address.description)
      expect(json['address']['company']).to     eq(address.company)
    end
  end

  def add_token_to_header(token)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token
      .encode_credentials(token)
  end
end
