class Section < ActiveRecord::Base

  has_many :pages,        :dependent => :destroy
  has_many :subsections,  :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of   :name

  cattr_reader :per_page
  @@per_page = 15

end

