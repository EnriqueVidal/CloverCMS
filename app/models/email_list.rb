class EmailList < ActiveRecord::Base
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_format_of     :email,     :with => /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/
  
  before_create :make_token
  
  def make_token
    self.token = Digest::SHA1.hexdigest( self.email + Time.now.to_s.split(//).sort_by{rand}.join )
  end
end
