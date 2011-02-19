class ApplicationController < ActionController::Base
  before_filter :set_locale
  layout :guess_layout

  rescue_from ActiveRecord::RecordNotFound,     :with => :record_missing
  rescue_from Clover::PageNotFoundError,        :with => :page_not_found
  rescue_from Clover::UnauthorizedAccessError,  :with => :unauthorized_access

  protect_from_forgery

  def check_authorization
    unless current_user.present? && (current_user.admin? || current_user.roles.detect do |role|
        role.rights.detect  do |right|
          right.action == action_name && right.controller ==  self.class.controller_path
        end
      end)
      raise Clover::UnauthorizedAccessError
    end
    true
  end

  def site_layout
    @site_layout ||= Setting.find_by_name('theme').value rescue nil
  end

  private
  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale]
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
    if site_layout.present?
      "themes/#{site_layout}/theme"
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
end
