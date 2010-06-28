# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def minimize_text(text, length)
    if text.length > length
      return text[0 .. (length - 4) ] + '...'
    else
      return text
    end
  end

  def render_flash_messages
    message = ''
    flash.each do |key, value|
      message << content_tag('div', value, :class => "flash #{key}", :id => "flash#{key.to_s.classify}" )
    end
    message
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object]  ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_for :jstemplates do
      content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
        form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|        
          render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })        
        end
      end
    end
  end

  def add_child_link(name, association)
    link_to(name, "#", :class => "add_child", :"data-association" => association)
  end

  def remove_child_link(name, f)
    f.hidden_field(:_delete) + link_to(name, "#", :class => "remove_child")
  end
  
  

  def say_it_in_spanish(time)
    time_in_spanish = time.gsub(/minute/, 'minuto').gsub(/hour/, 'hora').gsub(/day/, 'día').gsub(/less than a/, 'menos de un').gsub(/about/, '')
    time_in_spanish.gsub(/months/, 'meses').gsub(/month/, 'mes').gsub(/year/, 'año')
  end

  def strip_html(text)
    text.gsub(/<\/?[^>]*>/, "")
  end
  
  def coderay(code, lang)
    CodeRay.scan(code, lang).div(:css => :class, :line_numbers => :inline).gsub(/&amp;lt;/, "&lt;").gsub(/&amp;gt;/, "&gt;").gsub(/\n/, "\r")
  end

end

