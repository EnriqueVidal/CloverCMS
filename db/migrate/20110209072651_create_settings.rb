class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string  :name,  :null => false
      t.text    :value, :null => false
      t.string  :description
      t.boolean :destroyable, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
