class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.column  :description,     :string
      t.column  :page_id,         :integer
      t.column  :photo_file_name, :string
      t.column  :photo_file_size, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
