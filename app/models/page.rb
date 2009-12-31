class Page < ActiveRecord::Base
  acts_as_taggable

  belongs_to  :section
  belongs_to  :subsection
  belongs_to  :meta_title,         :class_name => 'MetaTag'
  belongs_to  :meta_description,   :class_name => 'MetaTag'

  has_many    :uploads, :dependent => :destroy, :attributes => true, :discard_if => proc { |upload| upload.description.blank? }

  validates_presence_of   :title, :body
  validates_uniqueness_of :title, :name

  before_create :create_page_name, :add_metatags
  before_update :create_page_name, :add_metatags

  cattr_reader :per_page
  @@per_page = 5

  def add_metatags
    self.meta_title_id        = MetaTag.first.id unless !self.meta_title_id.nil?
    self.meta_description_id  = MetaTag.first.id unless !self.meta_description_id.nil?
  end

  def create_page_name
    title  = self.title.gsub(/\s{2,}/, ' ').gsub(/\t/, ' ')
    self.name   = title.downcase.gsub(/(\s|\t)+/, '_').gsub(/_{2,}/, '_').gsub(/[^a-z_]/, '')
  end

end

