require 'rails_helper'

describe Api::V1::AddressesController do
  before do
    @user = create(:user)
    @user_account = @user.account
  end

  context '#index' do
    it 'sends a list of addresses associated to an account' do
      create_list(:address, 7, account_id: @user_account.id)
      create_list(:address, 5, account_id: 123)

      add_token_to_header(@user_account.test_api_key)

      get :index

      expect(response).to be_success
      expect(json['addresses'].count).to eq(7)
    end
  end

  context '#show' do
    it 'sends data regarding a specific address associated to an account' do
      address = create(:address, account_id: @user_account.id, id: 1)

      add_token_to_header(@user_account.test_api_key)

      get :show, { id: 1 }

      expect(response).to be_success
      expect(json['address']['id']).to          eq(1)
      expect(json['address']['description']).to eq(address.description)
      expect(json['address']['company']).to     eq(address.company)
    end
  end

  context '#create' do
    it 'allows users to POST a new address and create an address record' do
      address_body = FactoryGirl
        .attributes_for(:address)

      add_token_to_header(@user_account.test_api_key)

      post :create, address: address_body.as_json, format: :json

      expect(response).to be_success
      expect(@user_account.addresses.count).to eq 1
    end

    it 'triggers a 422 exception with missing required params' do
      address_body = FactoryGirl
        .attributes_for(:address, description: nil)

      add_token_to_header(@user_account.test_api_key)

      post :create, address: address_body.as_json, format: :json

      expect(response).to have_http_status(422)
      expect(@user_account.addresses.count).to eq 0
    end
  end

  def add_token_to_header(token)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token
      .encode_credentials(token)
  end

  def json
    JSON.parse(response.body)
  end
end
