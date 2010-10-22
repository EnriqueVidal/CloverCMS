class AddHasContactToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :has_contact, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :has_contact
  end
end
