class Api::V1::AddressesController < Api::V1::BaseController
  before_action :authenticate

  # GET /api/v1/addresses
  def index
    addresses = sessionizer.index

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
    address = sessionizer(uuid: params[:uuid]).show
    raise ActiveRecord::RecordNotFound if address.blank?

    render(json: Api::V1::AddressSerializer.new(address).to_json)
  end

  # POST /api/v1/addresses
  def create
    address = sessionizer(params: address_params).create
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
    address = sessionizer(uuid: params[:uuid]).destroy
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

  def sessionizer(params: nil, uuid: nil)
    @sessionizer ||= Sessionizer.new(
      params:     params,
      account_id: @account.id,
      uuid:       uuid,
      session:    session[:session_mode],
      account:    @account
    )
  end
end
