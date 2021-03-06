class ApplicationController < ActionController::Base
  extend ActiveSupport::Memoizable
  before_filter :set_locale, :authenticate_user!
  layout :guess_layout

  rescue_from ActiveRecord::RecordNotFound,     :with => :record_missing
  rescue_from Clover::PageNotFoundError,        :with => :page_not_found
  rescue_from Clover::UnauthorizedAccessError,  :with => :unauthorized_access
  rescue_from Acl9::AccessDenied,               :with => :unauthorized_access

  protect_from_forgery

  helper_method :site

  def site
    Setting.get_site_settings
  end

  private
  def set_locale
    session[:locale]  = params[:locale] if params[:locale].present?
    I18n.locale       = session[:locale] || site[:default_locale]
  end

  def devise_layout
    if controller_name == "registrations" && ( action_name == "edit" || action_name == "update" )
      set_tab :edit_user
      'dashboard'
    else
      'sessions'
    end
  end

  def website_layout
    if site[:theme].present?
      "themes/#{site[:theme]}/theme"
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

  protected
  def unauthorized_access
    flash[:info] = t 'messages.unauthorized_access'
    redirect_to new_user_session_path
    return false
  end

  def record_missing
    render 'public/404.html', :status => :not_found, :layout => false
    return false
  end

  def page_not_found
    render 'public/404.html', :status => :not_found, :layout => false
    return false
  end

  memoize :site
end
