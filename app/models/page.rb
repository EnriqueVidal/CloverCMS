class Page < ActiveRecord::Base
  include GenerateUrlName
  acts_as_taggable_on :keywords 
  has_many :assets, :as => :attachable
  belongs_to :section

  before_validation :strip_name
  before_save :check_home_page

  validates_presence_of     :name, :content
  validates_uniqueness_of   :name, :url_name, :allow_blank? => false, :allow_nil? => false
  validates_numericality_of :section_id, :message => 'needs to be set', :greater_than => 0

  scope :published, where(:published => true)

  def self.home_page
    where(:home_page => true).first
  end

  def check_home_page
    if home_page?
      page = Page.where("home_page = ?", true).first
      page.update_attributes(:home_page => false) if page != self
    end
  end
end
