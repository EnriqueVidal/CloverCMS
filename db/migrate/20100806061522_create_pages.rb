class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string  :name
      t.string  :url_name
      t.text    :content
      t.integer :section_id
      t.boolean :published,   :default => false
      t.boolean :home_page,   :default => false
      t.boolean :has_contact, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
