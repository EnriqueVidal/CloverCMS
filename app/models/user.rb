class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username
  has_attached_file :avatar, :styles => { :medium_scaled => "45x45>", :medium => "45x45#", :thumb_scaled => "50x50>", :thumb => "50x50#" }
  
  validates_presence_of   :username, :allow_blank => false, :allow_nil => :false
  validates_uniqueness_of :username
  validates_format_of     :username, :with => /^[a-z]([a-z0-9\-_.]{2,31})$/i
  
  has_many :authentications
  has_and_belongs_to_many :roles
  
  def apply_omniauth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  
  def password_required?
    authentications.empty? || !password.blank? && super
  end
end
