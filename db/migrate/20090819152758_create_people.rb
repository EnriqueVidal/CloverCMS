class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column      :first_name,          :string, :limit => 40, :null => false, :default => ''
      t.column      :middle_name,         :string, :limit => 40
      t.column      :last_name,           :string, :limit => 40, :null => false, :default => ''
      t.column      :date_of_birth,       :date
      t.column      :user_id,             :integer
      t.column      :photo_file_name,     :string
      t.column      :photo_content_type,  :string
      t.column      :photo_file_size,     :integer
      t.column      :gender,              :string

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

