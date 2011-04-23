class Section < ActiveRecord::Base
  include GenerateUrlName

  acts_as_authorization_object

  has_many    :pages
  has_many    :subsections,   :class_name => "Section", :foreign_key => :main_section_id
  belongs_to  :main_section,  :class_name => "Section", :foreign_key => :main_section_id

  before_validation       :strip_name
  validates_uniqueness_of :name,      :allow_blank => false
  validates_uniqueness_of :url_name,  :allow_blank => false, :allow_nil => false
  validates_presence_of   :name
end
