module GenerateUrlName
  def url_name
    self[:url_name] = name.downcase.gsub(/[^a-z-]/i, '-').gsub(/-{2,}/, '-').sub(/-$/, '') if name.present?
  end

  def strip_name
    self.name = name.to_s.strip
  end
end
