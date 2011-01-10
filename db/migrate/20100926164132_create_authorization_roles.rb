class CreateAuthorizationRoles < ActiveRecord::Migration
  def self.up
    create_table :authorization_roles do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :authorization_roles
  end
end
