class Page < ActiveRecord::Base
  belongs_to :section
  belongs_to :subsection
  
  validates_presence_of   :title, :body, :name
  validates_uniqueness_of :title
  validates_format_of     :name, :with => /^[a-zA-Z0-9_-]+$/
  
  cattr_reader :per_page
  @@per_page = 5
  
end
