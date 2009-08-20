class Section < ActiveRecord::Base

  has_many :pages,        :dependent => :destroy
  has_many :subsections,  :dependent => :destroy
  
  validates_uniqueness_of :name
  validates_presence_of   :name
end
