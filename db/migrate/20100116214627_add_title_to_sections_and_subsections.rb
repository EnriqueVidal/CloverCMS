class AddTitleToSectionsAndSubsections < ActiveRecord::Migration
  def self.up
    add_column :sections,     :title, :string
  end

  def self.down
    remove_column :sections,     :title
  end
end
