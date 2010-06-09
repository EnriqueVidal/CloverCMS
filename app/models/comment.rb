class Comment < ActiveRecord::Base
  belongs_to :article,      :counter_cache => true
  belongs_to :user,         :counter_cache => true
  belongs_to :commentable,  :polymorphic => true
  
  validates_presence_of :content, :user_id
end
