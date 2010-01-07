class Section < ActiveRecord::Base
  extend PaginateAndSort::ClassMethods
  
  has_many :pages,        :dependent => :destroy
  has_many :subsections,  :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of   :name

  sort_on :name, :created_at, :updated_at

end

