class Page < ActiveRecord::Base
  include GenerateUrlName
  
  has_and_belongs_to_many :related_pages, :class_name => "Page", :join_table => :related_pages, :foreign_key  => :main_page, :association_foreign_key => :related_page
                          
  has_and_belongs_to_many :child_pages, :class_name => "Page", :join_table => :related_pages, :foreign_key  => :related_page, :association_foreign_key => :main_page

  belongs_to  :section
  belongs_to  :meta_title,          :class_name => 'MetaTag'
  belongs_to  :meta_description,    :class_name => 'MetaTag'

  has_many    :uploads,   :as => :uploadable
  has_many    :photos,    :as => :uploadable, :dependent => :destroy
  has_many    :documents, :as => :uploadable, :dependent => :destroy

  validates_presence_of   :title, :body
  validates_uniqueness_of :title, :name

  before_create :create_name, :add_metatags, :fix_images_path
  before_update :create_name, :add_metatags, :fix_images_path

  accepts_nested_attributes_for :documents
  accepts_nested_attributes_for :photos

  acts_as_taggable

  def add_metatags
    self.meta_title_id        = MetaTag.first.id unless !self.meta_title_id.nil?
    self.meta_description_id  = MetaTag.first.id unless !self.meta_description_id.nil?
  end

  def fix_images_path
    self.body.gsub!(/src=\"images\//, 'src="/images/')
  end

end

