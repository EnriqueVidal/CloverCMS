class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.string :lang
      t.text :code
      t.integer :snippetable_id
      t.string :snippetable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
