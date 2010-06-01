class AddBioToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :bio,   :text
    add_column :people, :likes, :text
  end

  def self.down
    remove_column :people, :bio
    remove_column :people, :likes
  end
end
