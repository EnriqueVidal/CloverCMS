module GenerateUrlName
  def create_name
    title     = self.title.gsub(/\t/, ' ').gsub(/\s{2,}/, ' ')
    self.name = title.downcase.gsub(/(\s|\t)+/, '-').gsub(/_{2,}/, '-').gsub(/[^a-z-]/, '').gsub(/-$/, '').gsub(/-+/, '-')
  end
end