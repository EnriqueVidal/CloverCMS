class Article < ActiveRecord::Base
  include GenerateUrlName
  belongs_to  :user
  has_many    :assets, :as => :attachable, :dependent => :destroy

  before_validation :strip_name
  validates_presence_of   :name, :content
  validates_uniqueness_of :name
  validates_inclusion_of :kind, :in => %w(post news review)
  validate :create_url_name

  acts_as_taggable_on :keywords
end