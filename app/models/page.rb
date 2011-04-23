class Page < ActiveRecord::Base
  include GenerateUrlName

  acts_as_taggable_on :keywords
  acts_as_authorization_object

  has_many :assets, :as => :attachable
  belongs_to :section

  before_validation :strip_name
  before_save :check_home_page

  validates_presence_of     :name, :content, :section
  validates_uniqueness_of   :name, :url_name, :allow_blank? => false, :allow_nil? => false

  scope :published, where(:published => true)

  def self.home_page
    where(:home_page => true).first
  end

  def check_home_page
    if home_page?
      page = Page.where("home_page = ?", true).first
      page.update_attributes(:home_page => false) if page.present? && page != self
    end
  end
end
