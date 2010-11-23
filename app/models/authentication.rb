class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :provider, :uid
  
  def self.with_auth(provider, uid)
    find_or_create_by_provider_and_uid(provider, uid)
  end
end
