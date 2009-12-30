class Page < ActiveRecord::Base
  acts_as_taggable

  belongs_to  :section
  belongs_to  :subsection
  has_one     :meta_title,         :class_name => 'MetaTag', :foreign_key => :id
  has_one     :meta_description,   :class_name => 'MetaTag', :foreign_key => :id

  has_many    :uploads, :dependent => :destroy, :attributes => true, :discard_if => proc { |upload| upload.description.blank? }

  validates_presence_of   :title, :body, :name
  validates_uniqueness_of :title, :name
  validates_format_of     :name, :with => /^[a-zA-Z0-9_-]+$/

  cattr_reader :per_page
  @@per_page = 5

  after_create :fix_images_path
  after_update :fix_images_path

  def fix_images_path
    #self.body.gsub!(/src=\"images\//, 'src="/images/')
    logger.info "<<<<<" + self.body.to_s + ">>>>>"
    body = self.body
    body.gsub!(/src=\"images\//, 'src="/images/')
    self.update_attributes!(:body => body)
  end
end

