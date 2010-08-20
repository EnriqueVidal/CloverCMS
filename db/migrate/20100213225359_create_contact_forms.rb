class CreateContactForms < ActiveRecord::Migration
  def self.up
    create_table :contact_forms do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.string :subject
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_forms
  end
end
