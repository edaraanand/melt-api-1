class Api::V1::AddressSerializer < Api::V1::BaseSerializer
  attributes(
    :uuid,
    :description,
    :name,
    :company,
    :address_line_1,
    :address_line_2,
    :address_city,
    :address_state,
    :address_country,
    :address_zip,
    :phone,
    :email,
    :created_at,
    :updated_at
  )

  root false
end
