class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string  :name
      t.integer :main_section_id
      t.string  :url_name, :unique => true

      t.timestamps
    end

    add_index :sections, :main_section_id
  end

  def self.down
    remove_index :sections, :main_section_id

    drop_table :sections
  end
end
