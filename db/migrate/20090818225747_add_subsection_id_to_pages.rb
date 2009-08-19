class AddSubsectionIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :subsection_id, :integer
  end

  def self.down
    remove_column :pages, :subsection_id
  end
end
