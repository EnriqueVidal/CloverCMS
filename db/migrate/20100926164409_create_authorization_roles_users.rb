class CreateAuthorizationRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :authorization_roles_users, :id => false do |t|
      t.column :role_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :authorization_roles_users
  end
end
