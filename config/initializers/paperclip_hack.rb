#Workaround for paperclip in rails 3.0.3 as described here: http://bit.ly/brpgNN

if defined? ActionDispatch::Http::UploadedFile
  ActionDispatch::Http::UploadedFile.send(:include, Paperclip::Upfile)
end