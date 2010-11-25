class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string  :name
      t.string  :url_name
      t.text    :content
      t.boolean :published
      t.boolean :in_home_page
      t.boolean :type
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
