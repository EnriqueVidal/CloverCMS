class Section < ActiveRecord::Base
  extend PaginateAndSort

  has_many :pages,         :as       => :pageable,  :dependent => :destroy
  has_many :subsections,  :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of   :name

  sort_on :name, :created_at, :updated_at

end

