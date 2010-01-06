class Subsection < ActiveRecord::Base
  belongs_to  :section
  has_many    :pages, :dependent => :destroy
  
  validates_presence_of :name, :section_id

  sort_on :name, :created_at, :updated_at

  cattr_reader :per_page
  @@per_page = 15
  
  def self.paginate_and_sort_by_section_id(page, sort, section_id)
    options = self.sort_by(sort) || {}
    
    if !section_id.blank?
      return self.paginate_by_section_id(section_id, options.merge( :per_page => @@per_page, :page => page || 1)) rescue []
    else
      return self.paginate(options.merge( :per_page => @@per_page, :page => page || 1)) rescue []
    end
  end
end

