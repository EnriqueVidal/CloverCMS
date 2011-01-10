class Authorization::Right < ActiveRecord::Base
  set_table_name :authorization_rights

  validates_presence_of   :controller, :action
  has_and_belongs_to_many :roles, :class_name => 'Authorization::Role', :join_table => :authorization_rights_roles
end
