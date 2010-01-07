# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def minimize_text(text, length)
    if text.length > length
      return text[0 .. (length - 4) ] + '...'
    else
      return text
    end
  end
end

