class Document < Upload
  belongs_to :page
  has_attached_file :upload, :path  => ":rails_root/public/system/uploads/documents/:id/:style_:basename.:extension"
  
  validates_attachment_presence     :upload
  validates_attachment_content_type :upload, :content_type => [ 
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
  validates_attachment_size           :upload, :less_tan => 20.megabytes
  validate :check_file_extension
  
  # Excel extensions 	xls, xlc, xll, xlm, xlw, xlsx
  # Word extensions doc, docx
  # Powerpoint extensions ppt, ppz, pps, pot, pptx
  # Acrobat PDF Reader Extensions pdf
  
  private
  
  def check_file_extension
    extensions = %w( xls xlc xll xlm xlw xlsx doc docx ppt ppz pps pot pptx pdf )
    errors.add("File extension is invalid.") unless extensions.include? File.extname( upload.original_filename ).gsub( '.', '' ).downcase
  end
                                                                
end