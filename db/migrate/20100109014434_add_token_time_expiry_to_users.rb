class AddTokenTimeExpiryToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :token_expiry, :date
  end

  def self.down
    remove_column :users, :toke_expiry
  end
end
