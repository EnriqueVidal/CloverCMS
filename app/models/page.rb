class Page < ActiveRecord::Base
  include GenerateUrlName
  
  before_validation :strip_name
  before_save :is_home_page?
  
  belongs_to :section
  
  validates_presence_of     :name, :content
  validates_length_of       :content, :minimum => 50
  validates_uniqueness_of   :name
  validates_numericality_of :section_id, :message => 'needs to be set'
  validate                  :create_url_name
  
  scope :published, where(:published => true)
  
  def self.home_page
    where(:home_page => true).first
  end
  
  def is_home_page?
    if self.home_page
      @page = Page.where("home_page = ?", true).first
      @page.update_attributes(:home_page => false) if @page.present? && @page != self
    end
  end
end
