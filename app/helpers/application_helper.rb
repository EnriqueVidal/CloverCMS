# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user(id)
    User.find(id) unless id.nil?
  end
end

