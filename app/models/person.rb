class Person < ActiveRecord::Base
  belongs_to  :user
#  belongs_to  :city
#  belongs_to  :postal_code
#  has_many    :posts
#  has_many    :comments
  
  has_attached_file :photo, :path => ":rails_root/public/images/system/:class/:attachment/:id/:style_:basename.:extension", :styles => {
                                                                                                                                :thumb  => "29x29#",
                                                                                                                                :small  => "80x80#",
                                                                                                                                :medium => "180x180#"
                                                                                                                              }

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

# Commented for now, must revisit when new Geography database is implemented
  
#  def full_info
#    location_obj    = self.city         if !self.city_id.nil?
#    location_obj  ||= self.postal_code  if !self.postal_code_id.nil?
#     
#    full_name + ((location_obj.blank?) ? '' : ' de ' + location_obj.full_info)
#  end
  
#  def full_address    
#    if !self.city.nil?
#      return self.city.full_info
#    elsif !self.postal_code.nil?
#      return self.postal_code.full_info +  ', ' + self.postal_code.city.state.name + ', ' + self.postal_code.city.state.country.code + ', C.P. ' + self.postal_code.zip_code
#    end
#  end
  
end
