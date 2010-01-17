class Section < ActiveRecord::Base
  extend  PaginateAndSort
  include GenerateUrlName

  has_many :pages,         :as       => :pageable,  :dependent => :destroy
  has_many :subsections,  :dependent => :destroy

  validates_uniqueness_of :title
  validates_presence_of   :title

  sort_on :name, :created_at, :updated_at

  before_create :create_name
  before_update :create_name

end

