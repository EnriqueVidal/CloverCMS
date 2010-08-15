class Section < ActiveRecord::Base
  include GenerateUrlName
  
  has_many    :pages
  has_many    :subsections,   :class_name => "Section", :foreign_key => :main_section_id, :dependent => :destroy
  belongs_to  :main_section,  :class_name => "Section", :foreign_key => :main_section_id
  
  before_validation       :strip_name
  validates_uniqueness_of :name
  validates_presence_of   :name
  validate                :create_url_name
  
  def strip_name
    self.name = self.name.to_s.strip
  end
end
