class Upload < ActiveRecord::Base                                  
  validates_presence_of :description
  
  def upload_url(style=nil)
    return self.upload.path(style).split( RAILS_ROOT + '/public' )[1] if !style.nil?
    return self.upload.path.split( RAILS_ROOT + '/public' )[1]
  end 
end

