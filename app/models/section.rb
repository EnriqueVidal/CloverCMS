class Section < ActiveRecord::Base
  has_many :pages
  has_many :subsections
  
  validates_uniqueness_of :name
  validates_presence_of   :name
  
  
end
