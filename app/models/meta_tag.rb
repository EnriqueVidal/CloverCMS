class MetaTag < ActiveRecord::Base

  has_many :pages_meta_title,       :class_name => 'Page', :foreign_key => :meta_title_id
  has_many :pages_meta_description, :class_name => 'Page', :foreign_key => :meta_description_id

  validates_presence_of :content
  
  sort_on :content, :created_at, :updated_at
  
  cattr_reader :per_page
  @@per_page = 15
  
  def self.paginate_and_sort(page, sort)
    options = self.sort_by(sort) || {}
    return self.paginate( options.merge( :per_page => @@per_page, :page => page || 1)) rescue []
  end
end
