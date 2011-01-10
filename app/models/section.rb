class Section < ActiveRecord::Base
  include GenerateUrlName

  has_many    :pages
  has_many    :subsections,   :class_name => "Section", :foreign_key => :main_section_id, :dependent => :destroy
  belongs_to  :main_section,  :class_name => "Section", :foreign_key => :main_section_id

  before_validation       :strip_name
  validates_uniqueness_of :name, :url_name, :allow_blank? => false, :allow_nil? => false
  validates_presence_of   :name
end
