class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  
  has_attached_file :asset,
                     :path => ":rails_root/public/system/uploads/images/:id/:style_:basename.:extension",
                     :styles => {
                                   :squared => "120x80#",
                                   :small => "120x80>",
                                   :medium => "180x120>"
                                 }
  validates_attachment_presence      :asset
  validates_attachment_content_type  :asset, :content_type => [ 'image/jpeg', 'image/png', 'image/gif' ]
  validates_attachment_size :asset, :less_than => 20.megabytes
   
end