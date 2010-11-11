class Document < Asset
  has_attached_file :asset, :path => ":rails_root/public/system/uploads/documents/:id/:style_:basename.:extension"

  validates_attachment_presence     :asset
  validates_attachment_content_type :asset, :content_type => [
                                                                 'application/msword',
                                                                 'application/x-excel',
                                                                 'application/msexcel',
                                                                 'application/ms-excel',
                                                                 'application/x-msexcel',
                                                                 'application/vnd.ms-excel',
                                                                 'application/mspowerpoint',
                                                                 'application/vnd.ms-powerpoint',
                                                                 'application/pdf',
                                                                 'application/x-pdf',
                                                                 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                                                 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                                                                 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                                                               ]

  validates_attachment_size :asset, :less_tan => 20.megabytes
  validate :check_file_extension

 private

 def check_file_extension
   extensions = %w( xls xlsx doc docx ppt pptx pdf )
   errors.add("File extension is invalid.") unless extensions.include? File.extname( upload.original_filename ).gsub( '.', '' ).downcase
 end
end