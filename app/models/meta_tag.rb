class MetaTag < ActiveRecord::Base
  has_many :pages_meta_title,       :class_name => 'Page', :foreign_key => :meta_title_id
  has_many :pages_meta_description, :class_name => 'Page', :foreign_key => :meta_description_id

  validates_presence_of :content
end

