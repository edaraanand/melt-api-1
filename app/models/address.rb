class Address < ActiveRecord::Base
  include Randomized

  belongs_to :account

  validates :description, :name, :address_line_1, :address_city,
            :address_state, :address_zip, :address_country, presence: true

end
