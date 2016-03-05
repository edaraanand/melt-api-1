class AddAccountIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :account_id, :string
    add_index :addresses, :account_id
  end
end
