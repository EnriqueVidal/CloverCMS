class Subsection < ActiveRecord::Base
  extend PaginateAndSort

  belongs_to  :section
  has_many    :pages, :as => :pageable, :dependent => :destroy

  validates_presence_of :name, :section_id

  sort_on :name, :created_at, :updated_at
end

