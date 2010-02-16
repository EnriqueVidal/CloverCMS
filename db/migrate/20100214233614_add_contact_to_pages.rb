class AddContactToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :has_contact, :bool
  end

  def self.down
    remove_column :pages, :has_contact
  end
end
