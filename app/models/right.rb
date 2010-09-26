class Right < ActiveRecord::Base
  validates_presence_of :controller, :action
  
  has_and_belongs_to_many :roles
end
