require "rails_helper"

describe AddressesController do
  describe '#index' do
    context 'as current_user with an account' do
      it 'renders the :index view containing the addresses for that account' do
        create_user_and_sign_in

        account_addresses = double('account-addresses')
        expect_any_instance_of(Account)
          .to receive(:addresses)
          .and_return(account_addresses)

        get :index

        expect(assigns(:addresses)).to eq(account_addresses)
        expect(response).to render_template 'index'
      end
    end
  end

  describe '#show' do
    context 'as current_user with an account' do
      it 'renders the :show view for a specific address' do
        create_user_and_sign_in

        account_address = create(:address, uuid: 'adr_123', account_id: @user.account.id)

        get :show, uuid: account_address.uuid

        expect(assigns(:address)).to eq(account_address)
        expect(response).to render_template 'show'
      end
    end
  end

  describe '#new' do
    context 'as current_user with an account' do
      it 'renders the :new view while assigning a new Address to @address' do
        create_user_and_sign_in

        get :new

        expect(assigns(:address)).to be_a Address
        expect(response).to render_template 'new'
      end
    end
  end

  describe '#create' do
    context 'as current_user with an account' do
      it 'adds the created Address to the users account' do
        create_user_and_sign_in

        address_body = attributes_for(:address)

        post :create, address: address_body

        expect(assigns(:address)).to be_a Address
        expect(controller).to redirect_to(address_path(uuid: Address.last.uuid))
      end
    end
  end

  def create_user_and_sign_in
    @user = create(:user)
    @user.save
    sign_in @user
  end
end
