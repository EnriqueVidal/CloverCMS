class CreateRelatedPages < ActiveRecord::Migration
  def self.up
    create_table :related_pages do |t|
      t.integer :related_page
      t.integer :main_page
    end
  end

  def self.down
    drop_table :related_pages
  end
end
