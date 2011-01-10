class Authorization::Role < ActiveRecord::Base
  set_table_name :authorization_roles

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :users
  has_and_belongs_to_many :rights, :class_name => 'Authorization::Right', :join_table => :authorization_rights_roles
end
