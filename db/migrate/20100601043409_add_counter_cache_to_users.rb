class AddCounterCacheToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :comments_count, :integer, :default => 0
    add_column :users, :articles_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :comments_count
    remove_column :users, :articles_count
  end
end
