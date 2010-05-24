class User < ActiveRecord::Base

  has_one :person
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable, :activatable, :timeoutable,
         :rememberable, :trackable, :lockable, :confirmable#, :validatable,

  validates_presence_of     :username, :password
  validates_uniqueness_of   :username, :email
  validates_length_of       :username, :in => 5..20
  validates_format_of       :username, :with => /^[a-z0-9._-]+$/
  validates_format_of       :email,    :with => /^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
  validates_confirmation_of :password
  validates_length_of       :password, :in => 6..20
  validates_uniqueness_of   :username

   is_gravtastic :email, :secure => true, :filetype => :gif


  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation
end

