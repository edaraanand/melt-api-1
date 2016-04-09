require 'rails_helper'

describe Api::V1::AddressesController do
  before do
    @user = create(:user)
    @user_account = @user.account
    @user_account.live_api_key = 'live_api_key'
    @user_account.test_api_key = 'test_api_key'
    @user_account.save
  end

  describe '#index' do
    context 'with a test_api_key' do
      it 'sends the list of test addresses associated to an account' do
        create_list(:test_address, 7, account_id: @user_account.id)
        create_list(:test_address, 5, account_id: 123)

        add_token_to_header(@user_account.test_api_key)

        get :index

        expect(response).to be_success
        expect(json['data'].count).to eq(7)
      end
    end

    context 'with a live_api_key' do
      it 'sends the list of live addresses associated to an account' do
        create_list(:address, 7, account_id: @user_account.id)
        create_list(:address, 5, account_id: 123)

        add_token_to_header(@user_account.live_api_key)

        get :index

        expect(response).to be_success
        expect(json['data'].count).to eq(7)
      end
    end
  end

  describe '#show' do
    context 'with a test_api_key' do
      it 'sends data regarding a specific address associated to an account' do
        address = create(:test_address, account_id: @user_account.id)

        add_token_to_header(@user_account.test_api_key)

        get :show, { uuid: address.uuid }

        expect(response).to be_success
        expect(json['uuid']).to        eq(address.uuid)
        expect(json['description']).to eq(address.description)
        expect(json['company']).to     eq(address.company)
      end

      it 'sends a 404 when an address record is not found' do
        add_token_to_header(@user_account.test_api_key)

        get :show, { uuid: 'asdcaw1233' }

        expect(response).to have_http_status(404)
        expect(json['message']).to eq 'Record not found.'
      end
    end

    context 'with a live_api_key' do
      it 'sends data regarding a specific address associated to an account' do
        address = create(:address, account_id: @user_account.id)

        add_token_to_header(@user_account.live_api_key)

        get :show, { uuid: address.uuid }

        expect(response).to be_success
        expect(json['uuid']).to        eq(address.uuid)
        expect(json['description']).to eq(address.description)
        expect(json['company']).to     eq(address.company)
      end

      it 'sends a 404 when an address record is not found' do
        add_token_to_header(@user_account.live_api_key)

        get :show, { uuid: 'asdcaw1233' }

        expect(response).to have_http_status(404)
        expect(json['message']).to eq 'Record not found.'
      end
    end
  end

  describe '#create' do
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

  describe '#delete' do
    it 'allows the correct account to delete an address' do
      address = create(:address, account_id: @user_account.id)

      add_token_to_header(@user_account.test_api_key)

      delete :destroy, { uuid: address.uuid }

      expect(response).to have_http_status(200)
      expect(json['message']).to eq 'Success! Address has been deleted.'
      expect(Address.all).to eq []
    end

    it 'does not allow the incorrect account to update the address' do
      address = create(:address, account_id: @user_account.id)

      add_token_to_header('incorrect_token')

      delete :destroy, { uuid: address.uuid }

      expect(response).to have_http_status(401)
      expect(json['error']).to eq 'Invalid HTTP token. Access denied.'
      expect(Address.count).to eq 1
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
