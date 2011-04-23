class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  has_attached_file :avatar, :styles => {
                                          :medium_scaled  => "45x45>",
                                          :medium         => "45x45#",
                                          :thumb_scaled   => "50x50>",
                                          :thumb          => "50x50#"
                                        }

  acts_as_authorization_subject :association_name => :roles
  has_many :articles

  validates_format_of :username, :with => /^([a-z0-9\-_.]{2,31})$/i

  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username, :login

  protected
  def self.find_for_database_authentication(conditions)
    login = conditions.delete :login
    where(conditions).where([ "username = :value OR email = :value", { :value => login } ]).first
  end
end
