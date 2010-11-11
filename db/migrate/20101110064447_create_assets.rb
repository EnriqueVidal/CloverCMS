class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string  :description
      t.string  :asset_file_name
      t.integer :asset_file_size
      t.string  :type
      t.integer :attachable_id
      t.string  :attachable_type
    end
  end

  def self.down
   drop_table :assets
  end
end
