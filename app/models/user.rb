class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_attached_file :avatar, :styles => {
                                          :medium_scaled  => "45x45>",
                                          :medium         => "45x45#",
                                          :thumb_scaled   => "50x50>",
                                          :thumb          => "50x50#"
                                        }

  has_many                :articles
  has_and_belongs_to_many :roles

  validates_format_of :username, :with => /^([a-z0-9\-_.]{2,31})$/i

  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username
end
