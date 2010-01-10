class User < ActiveRecord::Base
  extend PaginateAndSort

  has_one                 :person,    :dependent => :destroy
  delegate                :full_name, :to => :person

  has_and_belongs_to_many :roles

  is_gravtastic             :email,     :secure => true,  :filetype => :gif

  validates_presence_of     :email,     :username
  validates_uniqueness_of   :email,     :username
  validates_confirmation_of :pass
  validates_format_of       :email,     :with => /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/
  validates_format_of       :username,  :with => /^[a-zA-Z0-9_-]+$/
  validates_length_of       :pass,      :minimum => 6, :if => :record_password_not_blank
  validates_length_of       :username,  :in => 4..15
  validate                  :password_not_blank

  before_create :make_token
  after_create  :create_person, :assign_roles

  sort_on :username, :email, :created_at, :admin

  cattr_reader :per_page
  @@per_page = 15

  named_scope :active,    :conditions => 'activation_date IS NOT NULL'
  named_scope :latest,    lambda { |limit|  { :limit => limit, :order => 'activation_date DESC' } }

  def create_person
    person = Person.create!( { :user_id => self.id } )
  end

  def assign_roles
    self.roles << Role.find_by_name('Member')
    self.roles << Role.find_by_name('Post comenter')
  end

  def self.authenticate(email_or_username, password)
    user    = User.active.find_by_email(email_or_username)
    user  ||= User.active.find_by_username(email_or_username)

    if user.blank? || User.encrypted_password(password, user.password_salt) != user.password
      user = nil
    end
    return user
  rescue ArgumentError => e
    logger.error "{e} for user {email}"
    return false
  end

  def pass
    @pass
  end

  def pass=(pass)
    @pass = pass
    return if pass.blank?
    salt = [ Array.new(6){ rand(256).chr }.join ].pack("m").chomp
    self.password_salt, self.password =  salt, User.encrypted_password(pass, salt)
  end

  def make_token
    self.token = Digest::SHA1.hexdigest( self.password_salt + Time.now.to_s.split(//).sort_by{rand}.join )
  end

  def activate
    @activated = true
    update_attributes!(:activation_date => Time.now.utc, :token => nil ) if self.activation_date.nil?
  end

  private

  def password_not_blank
    errors.add(:password, "can't be blank") if password.blank?
  end

  def record_password_not_blank
    return true if password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = Digest::SHA1.hexdigest( password + "grandma's recipe" + salt )
  end
end

