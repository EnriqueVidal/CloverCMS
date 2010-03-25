class Section < ActiveRecord::Base
  extend  PaginateAndSort
  include GenerateUrlName
  
  has_many    :subsections,   :class_name => "Section", :foreign_key => :main_section_id, :dependent => :destroy
  belongs_to  :main_section,  :class_name => "Section", :foreign_key => :main_section_id
  
  has_many :pages, :as => :pageable, :dependent => :destroy

  validates_uniqueness_of :title
  validates_presence_of   :title

  sort_on :name, :created_at, :updated_at

  before_create :create_name
  before_update :create_name

end

