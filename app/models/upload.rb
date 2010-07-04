class Upload < ActiveRecord::Base
  
  belongs_to            :uploadable, :polymorphic => true                                  
  validates_presence_of :description
  
  def upload_url(style=nil)
    self.upload.path(style).split( RAILS_ROOT + '/public' ).last
  end 
end

