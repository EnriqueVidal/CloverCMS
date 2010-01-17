class Page < ActiveRecord::Base
  extend  PaginateAndSort
  include GenerateUrlName

  acts_as_taggable

  belongs_to  :pageable,            :polymorphic => true
  belongs_to  :meta_title,          :class_name => 'MetaTag'
  belongs_to  :meta_description,    :class_name => 'MetaTag'

  has_many    :uploads,   :as => :uploadable
  has_many    :photos,    :as => :uploadable, :dependent => :destroy, :attributes => true, :discard_if => proc { |upload| upload.description.blank? }
  has_many    :documents, :as => :uploadable, :dependent => :destroy, :attributes => true, :discard_if => proc { |upload| upload.description.blank? }

  validates_presence_of   :title, :body
  validates_uniqueness_of :title, :name

  before_create :create_name, :add_metatags, :fix_images_path
  before_update :create_name, :add_metatags, :fix_images_path

  sort_on :title, :created_at, :updated_at

  def add_metatags
    self.meta_title_id        = MetaTag.first.id unless !self.meta_title_id.nil?
    self.meta_description_id  = MetaTag.first.id unless !self.meta_description_id.nil?
  end

  def fix_images_path
    self.body.gsub!(/src=\"images\//, 'src="/images/')
  end

end

