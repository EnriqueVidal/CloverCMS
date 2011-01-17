class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_attached_file :avatar, :styles => {
                                          :medium_scaled  => "45x45>",
                                          :medium         => "45x45#",
                                          :thumb_scaled   => "50x50>",
                                          :thumb          => "50x50#"
                                        }
  has_many :articles
  has_and_belongs_to_many :roles, :class_name => 'Authorization::Role', :join_table => :authorization_roles_users

  validates_format_of :username, :with => /^([a-z0-9\-_.]{2,31})$/i

  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username

  def add_roles collection=[]
    begin
      self.roles = []
      collection.each do |id|
        self.roles << Authorization::Role.find(id)
      end
      true
    rescue
      false
    end
  end
end
