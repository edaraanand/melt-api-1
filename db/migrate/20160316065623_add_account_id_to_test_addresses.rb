class AddAccountIdToTestAddresses < ActiveRecord::Migration
  def change
    add_column :test_addresses, :account_id, :integer
    add_index :test_addresses, :account_id
  end
end
