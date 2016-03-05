# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(email: 'glenn@glenn.com', password: 'password').save
User.create(email: 'test@test.com', password: 'password').save

a1 = Account.first
a1.addresses.create(description:     'Account 1 - Address 1',
                    name:            'Glenn Test',
                    address_line_1:  '123 Fake St',
                    address_line_2:  'Suite 100',
                    address_city:    'San Francisco',
                    address_state:   'CA',
                    address_zip:     '94201',
                    address_country: 'US',
                    company:         'Melt',
                    phone:           '222-222-222',
                    email:           'e1@glenn.com').save

15.times do
  a1.addresses.create(description:     Faker::Lorem.sentence,
                      name:            Faker::Name.name,
                      company:         Faker::Company.name,
                      address_line_1:  Faker::Address.street_address,
                      address_line_2:  Faker::Address.secondary_address,
                      address_city:    Faker::Address.city,
                      address_state:   Faker::Address.state,
                      address_zip:     Faker::Address.zip,
                      address_country: Faker::Address.country,
                      phone:           Faker::PhoneNumber.cell_phone,
                      email:           Faker::Internet.email).save
end

a2 = Account.last
5.times do
  a2.addresses.create(description:     Faker::Lorem.sentence,
                      name:            Faker::Name.name,
                      company:         Faker::Company.name,
                      address_line_1:  Faker::Address.street_address,
                      address_line_2:  Faker::Address.secondary_address,
                      address_city:    Faker::Address.city,
                      address_state:   Faker::Address.state,
                      address_zip:     Faker::Address.zip,
                      address_country: Faker::Address.country,
                      phone:           Faker::PhoneNumber.cell_phone,
                      email:           Faker::Internet.email).save
end


