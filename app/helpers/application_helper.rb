module ApplicationHelper
  def controller_trans strip_namespace=true
    if strip_namespace
      params[:controller].gsub(/\//, '.')
    else
      params[:controller]
    end
  end

  def model_trans strip_namespace=true
    if strip_namespace
      params[:controller].split(/\//).last.singularize
    else
      params[:controller].gsub(/\//, '.').singularize
    end
  end

  def available_section_list section_name
    Section.where("name != '#{section_name}'").map { |section| [ section.name, section.id ] }
  end
end
