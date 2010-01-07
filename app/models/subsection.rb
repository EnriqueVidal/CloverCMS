class Subsection < ActiveRecord::Base
  extend PaginateAndSort::ClassMethods
  
  belongs_to  :section
  has_many    :pages, :dependent => :destroy
  
  validates_presence_of :name, :section_id

  sort_on :name, :created_at, :updated_at
end

