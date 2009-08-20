class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column  :email,           :string, :limit => 40, :null => false
      t.column  :password,        :string
      t.column  :password_salt,   :string
      t.column  :token,           :string
      t.column  :activation_date, :date
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
