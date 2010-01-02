class Subsection < ActiveRecord::Base
  belongs_to  :section
  has_many    :pages, :dependent => :destroy

  cattr_reader :per_page
  @@per_page = 15
end

