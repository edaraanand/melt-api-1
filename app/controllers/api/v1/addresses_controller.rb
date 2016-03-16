class Api::V1::AddressesController < Api::V1::BaseController
  before_action :authenticate

  # GET /api/v1/addresses
  def index
    addresses = find_all_based_on_session(@account.id)

    render(
      json: ActiveModel::ArraySerializer.new(
        addresses,
        each_serializer: Api::V1::AddressSerializer,
        root: 'data'
      )
    )
  end

  # GET /api/v1/address/:id
  def show
    address = @account.addresses.where(uuid: params[:uuid]).first
    raise ActiveRecord::RecordNotFound if address.blank?

    render(json: Api::V1::AddressSerializer.new(address).to_json)
  end

  # POST /api/v1/addresses
  def create
    address = @account.addresses.create(address_params)
    return api_error(status: 422, errors: address.errors) unless address.valid?

    address.save!

    render(
      json: Api::V1::AddressSerializer.new(address).to_json,
      status: 201,
      location: api_v1_address_path(address.id)
    )
  end

  # DELETE /api/v1/addresses/:id
  def destroy
    address = @account.addresses.where(uuid: params[:uuid]).first.destroy
    return api_error(status: 500) unless address.destroy

    render(json: { 'message': 'Success! Address has been deleted.' })
  end

  private

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
