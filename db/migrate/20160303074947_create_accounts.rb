class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :uuid
      t.string :test_api_key, null: false
      t.string :live_api_key
      t.timestamps null: false
    end
  end
end
