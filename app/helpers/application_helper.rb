module ApplicationHelper
  def main_sections_collection section_name
    Section.where("name != '#{section_name}'").map { |section| [ section.name, section.id ] }
  end

  def all_sections_collection
    Section.all.map { |section| [ section.name, section.id ] }
  end
end
