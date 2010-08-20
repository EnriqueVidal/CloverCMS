class CreateMetaTags < ActiveRecord::Migration
  def self.up
    create_table :meta_tags do |t|
      t.column :content, :string
      t.timestamps
    end
    
    add_column :pages, :meta_title_id,        :integer
    add_column :pages, :meta_description_id,  :integer
    
  end

  def self.down
    drop_table :meta_tags
    
    remove_column :pages, :meta_title_id
    remove_column :pages, :meta_description_id
  end
end
