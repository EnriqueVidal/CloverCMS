class AddMainPageToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :main_page, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :main_page
  end
end
