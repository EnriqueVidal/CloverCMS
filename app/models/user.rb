class User < ActiveRecord::Base
  USERNAME_EXP = /^([a-z0-9\-_.]{2,31})$/i
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_attached_file :avatar, :styles => { :medium_scaled => "45x45>", :medium => "45x45#", :thumb_scaled => "50x50>", :thumb => "50x50#" }
  
  validates_format_of :username, :with => USERNAME_EXP

  has_many :authentications
  has_many :posts,  :class_name => 'Articles::Post'
  has_many :news,   :class_name => 'Articles::News'
  has_and_belongs_to_many :roles  

  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username
  
  def apply_omniauth(auth, email=nil)
    handle_auth auth, email
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  
  def password_required?
    (authentications.empty? || password.present?) && super
  end
  
  private
  
  def handle_auth(auth, email=nil)
    case auth['provider']
    when 'facebook'
      self.email    = email if self.email.blank? && email
      self.username = fix_username(auth, email) if self.username.blank?
    
    when 'open_id'
      self.email    = email if self.email.blank? && email.present?
      self.username = fix_username(auth, self.email)
      
    when 'twitter'
      self.username = auth['user_info']['nickname'] if self.username.blank?
    end    
  end
  
  def fix_username(auth, email)
    if auth['user_info']['nickname'] !~ USERNAME_EXP
      return email.split(/@/)[0] if self.username !~ USERNAME_EXP
    end
    auth['user_info']['nickname']
  end
end
