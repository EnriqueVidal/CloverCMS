module ApplicationHelper
  def main_sections_collection section_name
    Section.where("name != '#{section_name}'").map { |section| [ section.name, section.id ] }
  end

  def all_sections_collection
    Section.all.map { |section| [ section.name, section.id ] }
  end

  def article_kinds
    types = 'dashboard.articles.types'
    [ %W(#{t("#{types}.post")} post), %W(#{t("#{types}.review")} review), %W(#{t("#{types}.news")} news) ]
  end

  def controller_name
    params[:controller].singularize.split('/')[1]
  end
end
