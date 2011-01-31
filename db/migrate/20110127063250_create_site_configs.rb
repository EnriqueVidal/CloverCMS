class CreateSiteConfigs < ActiveRecord::Migration
  def self.up
    create_table :site_configs do |t|
      t.text :google_analytics
      t.string :theme

      t.timestamps
    end
  end

  def self.down
    drop_table :site_configs
  end
end
