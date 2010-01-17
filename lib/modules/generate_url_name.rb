module GenerateUrlName
  def create_name
    title     = self.title.gsub(/\s{2,}/, ' ').gsub(/\t/, ' ')
    self.name = title.downcase.gsub(/(\s|\t)+/, '-').gsub(/_{2,}/, '-').gsub(/[^a-z-]/, '').gsub(/-$/, '')
  end
end