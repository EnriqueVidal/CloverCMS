class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string  :description
      t.string  :asset_file_name
      t.string  :asset_content_type
      t.integer :asset_file_size
      t.integer :attachable_id
      t.string  :attachable_type
    end

    add_index :assets, :asset_content_type
    add_index :assets, [ :attachable_id, :attachable_type ]
  end

  def self.down
    remove_index :assets, [ :attachable_id, :attachable_type ]
    remove_index :assets, :asset_content_type

    drop_table :assets
  end
end
