class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :user_id, :allow_nil? => false, :allow_blank? => false
end
