class Api::V1::AddressesController < Api::V1::BaseController
  before_action :authenticate

  def index
    addresses = Address.all

    render(
      json: ActiveModel::ArraySerializer.new(
        addresses,
        each_serializer: Api::V1::AddressSerializer,
        root: 'addresses'
      )
    )
  end

  def show
    address = Address.find(params[:id])

    render(json: Api::V1::AddressSerializer.new(address).to_json)
  end
end
