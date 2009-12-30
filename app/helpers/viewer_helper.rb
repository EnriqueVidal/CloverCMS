module ViewerHelper
  def fix_images_path(content_body)
    content_body.gsub(/src=\"images\//, 'src="/images/')
  end
end
