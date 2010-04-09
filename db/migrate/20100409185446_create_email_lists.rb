class CreateEmailLists < ActiveRecord::Migration
  def self.up
    create_table :email_lists do |t|
      t.string :email, :unique => true
      t.string :token, :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :email_lists
  end
end
