class Api::V1::AddressesController < Api::V1::BaseController
  def show
    address = Address.find(params[:id])

    render(json: Api::V1::AddressSerializer.new(address).to_json)
  end
end
