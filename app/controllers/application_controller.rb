class ApplicationController < ActionController::Base
  DEVISE_CONTROLLERS = %w/sessions passwords registrations confirmations/

  before_filter :set_locale
  layout :layout_for_devise, :if => lambda { DEVISE_CONTROLLERS.include? controller_name }

  protect_from_forgery

  def check_authorization
     unless current_user.present? && (current_user.admin? || current_user.roles.detect do |role|
       role.rights.detect  do |right|
         right.action == action_name && right.controller ==  self.class.controller_path
         end
       end )

       flash[:info] = t 'messages.unauthorized_access'
       redirect_to new_user_session_path
       return false
     end
   end

  private
  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale]
  end

  def layout_for_devise
    if devise_controller?
      if controller_name == "registrations" && action_name == "edit"
        set_tab :edit_user
        'dashboard'
      else
        'sessions'
      end
    end
  end
end
