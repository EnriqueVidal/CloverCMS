class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :provider, :uid
end
