FactoryGirl.define do
  factory :address do
    description     Faker::Lorem.sentence
    name            Faker::Name.name
    company         Faker::Company.name
    address_line_1  Faker::Address.street_address
    address_line_2  Faker::Address.secondary_address
    address_city    Faker::Address.city
    address_state   Faker::Address.state
    address_zip     Faker::Address.zip
    address_country Faker::Address.country
    phone           Faker::PhoneNumber.cell_phone
    email           Faker::Internet.email
  end
end
