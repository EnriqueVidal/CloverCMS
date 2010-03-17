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
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
  
end

