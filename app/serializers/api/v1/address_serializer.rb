class Api::V1::AddressSerializer < Api::V1::BaseSerializer
  attributes(
    :uuid,
    :description,
    :name,
    :phone,
    :email,
    :company,
    :address_line_1,
    :address_line_2,
    :address_city,
    :address_state,
    :address_zip,
    :address_country,
    :created_at,
    :updated_at
  )

  root false
end
