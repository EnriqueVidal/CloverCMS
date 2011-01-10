class ApplicationController < ActionController::Base
  before_filter :set_locale

  protect_from_forgery

  def check_authorization
     unless current_user.present? && (current_user.admin? || current_user.roles.detect do |role|
       role.rights.detect  do |right|
         right.action == action_name && right.controller ==  self.class.controller_path
         end
       end )

       flash[:notice] = "No estas autorizado para ver la pagina que haz solicitado"
       redirect_to new_user_session_path
       return false
     end
   end

  private
  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale]
  end
end
