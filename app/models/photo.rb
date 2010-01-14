class Photo < Upload
  belongs_to :page
  
  has_attached_file :upload,
                    :path     => ":rails_root/public/system/uploads/photos/:id/:style_:basename.:extension",
                    :styles   => {
                                    :small  => "80x80>",
                                    :medium => "180x180>"
                                  }
                                  
  validates_attachment_presence     :upload
  validates_attachment_content_type :upload, :content_type => [
                                                                'image/jpeg',
                                                                'image/png',
                                                                'image/gif'
                                                              ]
  validates_attachment_size         :upload,  :less_than => 20.megabytes
  validate :check_file_extension
  
  private
                           
  def check_file_extension
    extensions = %w( png gif jpg jpeg )
    errors.add("File extension is invalid.") unless extensions.include? File.extname( upload.original_filename).gsub('.', '').downcase
  end                                
end