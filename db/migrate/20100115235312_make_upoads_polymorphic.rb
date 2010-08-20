class MakeUpoadsPolymorphic < ActiveRecord::Migration
  def self.up
    add_column :uploads, :uploadable_id,    :integer
    add_column :uploads, :uploadable_type,  :string
    remove_column :uploads, :page_id
  end

  def self.down
    remove_column :uploads, :uploadable_id
    remove_column :uploads, :uploadable_type
    add_column    :uploads, :page_id, :integer
  end
end
