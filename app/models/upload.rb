class Upload < ActiveRecord::Base                                  
  validates_presence_of :description
  
  def upload_url(style)
    self.upload.path(style).split( RAILS_ROOT + "/public" )[1]
  end 
end

