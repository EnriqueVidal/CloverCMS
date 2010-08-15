class Person < ActiveRecord::Base
  belongs_to  :user

  has_attached_file :photo, :path => ":rails_root/public/images/system/:class/:attachment/:id/:style_:basename.:extension", :styles => {
                                                                          :thumb  => "29x29#",
                                                                          :small  => "80x80#",
                                                                          :medium => "180x180#"
                                                                        }
                                                                        
  validates_inclusion_of :gender, :in => [ 'male', 'female' ], :allow_blank => true

  named_scope :female,    :conditions => "gender = 'female'"
  named_scope :male,      :conditions => "gender = 'male'"
  named_scope :has_photo, :conditions => "photo_file_name IS NOT NULL"

  def photo_url(style)
    path = self.photo.path(style).split( RAILS_ROOT + "/public" )
    path[1]
  end

  def full_name
    name  = self.first_name + ((self.middle_name.blank?) ? ' ' : ' ' + self.middle_name + ' ') + self.last_name
  end

end

