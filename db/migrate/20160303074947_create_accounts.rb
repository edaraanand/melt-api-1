class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: false do |t|
      t.string :id,         primary_key: true
      t.string :test_api_key, null: false
      t.string :live_api_key
      t.timestamps null: false
    end
  end
end
