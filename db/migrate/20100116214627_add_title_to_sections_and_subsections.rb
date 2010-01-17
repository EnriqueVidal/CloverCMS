class AddTitleToSectionsAndSubsections < ActiveRecord::Migration
  def self.up
    add_column :sections,     :title, :string
    add_column :subsections,  :title, :string
  end

  def self.down
    remove_column :sections,     :title
    remove_column :subsections,  :title
  end
end
