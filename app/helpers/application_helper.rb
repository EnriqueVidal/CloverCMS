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
end

