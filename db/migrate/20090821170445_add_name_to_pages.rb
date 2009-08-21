class AddNameToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :name, :string
  end

  def self.down
    remove_column :pages, :name
  end
end
