class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :description
      t.string :name
      t.string :company
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_city
      t.string :address_state
      t.string :address_zip
      t.string :address_country
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
