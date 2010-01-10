class MetaTag < ActiveRecord::Base
  extend PaginateAndSort

  has_many :pages_meta_title,       :class_name => 'Page', :foreign_key => :meta_title_id
  has_many :pages_meta_description, :class_name => 'Page', :foreign_key => :meta_description_id

  validates_presence_of :content

  sort_on :content, :created_at, :updated_at

end

