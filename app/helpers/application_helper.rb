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

  def meta(name, content)
    %(<meta name="#{name}" content="#{content}" />)
  end

  def new_child_fields_template(form_builder, association, options={})
    options[:object]  ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_for :resource_templates do
      content_tag(:div, :id => "#{options[:partial]}_fields_template", :style => "display: none") do
        form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
          render :partial => options[:partial], :locals => { options[:form_builder_local] => f }
        end
      end
    end
  end

  def add_child_fields_link(name, association)
    link_to name, "#", :class => 'add_child', :"data-association" => association
  end

  def remove_child_fields_link(name, form_builder)
    form_builder.hidden_field(:_destroy) + link_to(name, "#", :class => "remove_child")
  end
end
