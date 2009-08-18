class CreateSubsections < ActiveRecord::Migration
  def self.up
    create_table :subsections do |t|
      t.column :name, :string
      t.column :section_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :subsections
  end
end
