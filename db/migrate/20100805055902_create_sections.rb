class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string  :name
      t.integer :main_section_id
      t.string  :url_name, :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
