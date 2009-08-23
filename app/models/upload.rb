class Upload < ActiveRecord::Base
    belongs_to :page
    has_attached_file :photo, 
                      :path => ":rails_root/public/images/system/:class/:attachment/:id/:style_:basename.:extension", 
                      :styles => {
                                    :thumb  => [ "80x80#",    :jpg ],
                                    :small  => [ "180x180#",  :jpg ],
                                    :medium => [ "380x380#",  :jpg ]
                                  }

end
