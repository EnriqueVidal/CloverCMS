class Section < ActiveRecord::Base

  has_many :pages,        :dependent => :destroy
  has_many :subsections,  :dependent => :destroy

  validates_uniqueness_of :name
  validates_presence_of   :name

  sort_on :name, :created_at, :updated_at

  cattr_reader :per_page
  @@per_page = 15

  def self.paginate_and_sort(page, sort)
    options = self.sort_by(sort) || {}
    return self.paginate( options.merge( :per_page => @@per_page, :page => page || 1)) rescue []
  end

end

