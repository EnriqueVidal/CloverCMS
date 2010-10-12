class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar
  has_attached_file :avatar, :styles => { :medium_scaled => "45x45>", :medium => "45x45#", :thumb_scaled => "50x50>", :thumb => "50x50#" }
  
  has_and_belongs_to_many :roles
end
