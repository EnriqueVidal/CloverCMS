class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :description
      t.string :action
      t.string :controller

      t.timestamps
    end
  end

  def self.down
    drop_table :rights
  end
end
