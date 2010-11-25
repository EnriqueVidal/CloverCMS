class Article < ActiveRecord::Base
  include GenerateUrlName
  self.abstract_class = true
  set_table_name :articles
  
  acts_as_taggable_on :keywords
  belongs_to  :user
  has_many    :assets, :as => :attachable, :dependent => :destroy

  before_validation :strip_name
  validates_presence_of   :name, :content
  validates_uniqueness_of :name
  validate :create_url_name
end
