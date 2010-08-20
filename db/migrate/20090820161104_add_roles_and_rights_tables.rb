class AddRolesAndRightsTables < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer
      t.column :user_id, :integer
    end
    
    create_table :rights_roles, :id => false do |t|
      t.column :right_id, :integer
      t.column :role_id,  :integer
    end
  end

  def self.down
    drop_table :roles_users
    drop_table :rights_roles
  end
end
