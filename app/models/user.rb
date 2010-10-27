class User < ActiveRecord::Base
  $USER_EXP = /^([a-z0-9\-_.]{2,31})$/i
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username
  has_attached_file :avatar, :styles => { :medium_scaled => "45x45>", :medium => "45x45#", :thumb_scaled => "50x50>", :thumb => "50x50#" }
  
  validates_format_of     :username, :with => $USER_EXP
  has_many :authentications
  has_and_belongs_to_many :roles
  
  def apply_omniauth(auth, email=nil)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
    handle_auth auth, email
  end
  
  def password_required?
    (authentications.empty? || password.present?) && super
  end
  
  private
  
  def handle_auth(auth, email=nil)    
    case auth['provider']
    when 'facebook'
      self.email    = email if self.email.blank? && email
      self.username = fix_username(auth, email) if username.
    
    when 'open_id'
      self.email    = email if self.email.blank? && email
      self.username = fix_username(auth, email)
      
    when 'twitter'
      self.username = auth['user_info']['nickname'] if self.username.blank?
    end    
  end
  
  def fix_username(auth, email)
    if auth['user_info']['nickname'] !~ $USER_EXP
      return email.split(/@/)[0] if self.username !~ $USER_EXP
    end
    auth['user_info']['nickname']
  end
end
