class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :crest
      t.text :body
      t.integer :user_id
      t.boolean :show_in_homepage
      t.boolean :is_news
      t.boolean :is_post
      t.boolean :is_review
      t.string :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
