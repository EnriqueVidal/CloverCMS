class AddRelatedSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :main_section_id, :integer
  end

  def self.down
    remove_column :sections, :main_section_id
  end
end
