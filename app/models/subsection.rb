class Subsection < ActiveRecord::Base
  extend  PaginateAndSort
  include GenerateUrlName

  belongs_to  :section
  has_many    :pages, :as => :pageable, :dependent => :destroy

  validates_presence_of :title, :section_id

  sort_on :name, :created_at, :updated_at
  
  before_create :create_name
  before_update :create_name
  
end

