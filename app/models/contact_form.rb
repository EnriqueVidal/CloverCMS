class ContactForm < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :email,      :string
  column :subject,    :string
  column :name,       :string
  column :phone,      :string
  column :message,    :text
  
  validates_presence_of :email, :name, :message
  validates_format_of   :email,   :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of   :message, :maximum => 500
end
