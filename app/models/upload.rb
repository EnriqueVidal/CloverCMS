require 'RMagick'
  
class Upload < ActiveRecord::Base
    belongs_to :page
    has_attached_file :photo, 
                      :path => ":rails_root/public/images/system/:class/:attachment/:id/:style_:basename.:extension", 
                      :styles => {
                                    :small  => [ "180x180#",  :png ],
                                    :medium => [ "380x380#",  :png ]
                                  }
                                  
  attr_accessor :x1, :y1, :width, :height
  
  def photo_url(style)
    path = self.photo.path(style).split( RAILS_ROOT + "/public" ) 
    path[1]
  end

  def update_attributes(att)

    # Should we crop?
    scaled_img  = Magick::ImageList.new(self.photo.path)
    orig_img    = Magick::ImageList.new(self.photo.path(:original))
    
    scale       = orig_img.columns.to_f / scaled_img.columns

    args = [ att[:x1], att[:y1], att[:width], att[:height] ]
    args = args.collect { |a| a.to_i * scale }

    orig_img.crop!(*args)
    orig_img.write(self.photo.path(:original))

    self.photo.reprocess!
    self.save

    super(att)
  end
  
end
