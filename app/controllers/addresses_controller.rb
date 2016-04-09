class AddressesController < ApplicationController
  layout 'dashboard'

  before_action :set_address, only: [:show, :destroy]

  def index
    @addresses = current_user.account.addresses
  end

  def show
  end

  def new
    @address = current_user.account.addresses.new
  end

  def create
    @address = current_user.account.addresses.create(address_params)

    if @address.save
      redirect_to address_path(@address.uuid), notice: 'Address Created.'
    else
      render action: 'new'
    end
  end

  private

  def set_address
    @address = Address.where(uuid: params[:uuid]).first
  end

  def address_params
    params.require(:address).permit(
      :description,
      :name,
      :address_line_1,
      :address_line_2,
      :address_city,
      :address_state,
      :address_zip,
      :address_country,
      :company,
      :phone,
      :email
     )
  end
end
