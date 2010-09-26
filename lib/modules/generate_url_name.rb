module GenerateUrlName
  def create_url_name
    name            = self.name.strip.gsub(/\t/, ' ').gsub(/\s{2,}/, ' ')
    self.url_name   = name.downcase.gsub(/(\s|\t)+/, '-').gsub(/_{2,}/, '-').gsub(/[^a-z-]/, '').gsub(/-$/, '')
    current_object  = self.class.find_by_url_name( self.url_name ) if self.class.exists?( :url_name => self.url_name )
    
    errors.add(:url_name, "has been taken.") if current_object.present? && current_object != self
  end
  
  def strip_name
    self.name = self.name.to_s.strip
  end
end