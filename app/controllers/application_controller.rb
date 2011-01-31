class ApplicationController < ActionController::Base
  before_filter :set_locale
  layout :guess_layout

  protect_from_forgery

  helper_method :site_config

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

  def site_config
    @site_config ||= SiteConfig.last
  end

  private
  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale]
  end

  def devise_layout
    if controller_name == "registrations" && action_name == "edit"
      set_tab :edit_user
      'dashboard'
    else
      'sessions'
    end
  end

  def website_layout
    if site_config.present?
      "themes/#{site_config.theme}/theme"
    else
      'themes/default/theme'
    end
  end

  def dashboard_controller?
    params[:controller] =~ /^dashboard\/[a-z_]+$/
  end

  def guess_layout
    if dashboard_controller?
      'dashboard'
    elsif devise_controller?
      devise_layout
    else
      website_layout
    end
  end
end
