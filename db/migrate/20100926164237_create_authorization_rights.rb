class CreateAuthorizationRights < ActiveRecord::Migration
  def self.up
    create_table :authorization_rights do |t|
      t.string :description
      t.string :action,     :null => false
      t.string :controller, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :authorization_rights
  end
end
