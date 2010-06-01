class Article < ActiveRecord::Base
  include GenerateUrlName
  
  belongs_to  :user
  has_many    :uploads,   :as => :uploadable
  has_many    :photos,    :as => :uploadable, :dependent => :destroy
  has_many    :documents, :as => :uploadable, :dependent => :destroy
  
  validates_uniqueness_of :title
  validates_presence_of   :title, :body, :crest
  
  before_create :create_name
  before_update :create_name
  
  accepts_nested_attributes_for :photos,  :reject_if => lambda { |a| a[:description].blank? }, :allow_destroy => true
  
  named_scope :blogs,   :conditions => { :is_post   => true }
  named_scope :news,    :conditions => { :is_news   => true }
  named_scope :reviews, :conditions => { :is_review => true }
end
