# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'application'

  before_filter :session_expiry

  def session_expiry
    if session[:expiry_time] and session[:expiry_time] < Time.now
      reset_session

      if request.xhr?
        session[:expiry_time] = 10.minutes.from_now
        render :update do |page|
          page.redirect_to :login
        end
      end
    end

    session[:expiry_time] = 10.minutes.from_now
    return true
  end

  def referer
    request.env["HTTP_REFERER"]
  end

  def check_authorization
    unless !current_user.nil? && (current_user.admin? || current_user.roles.detect  { |role| role.rights.detect  { |right| right.action == action_name && right.controller ==  self.class.controller_path } } )

      flash[:notice] = "No estas autorizado para ver la pagina que haz solicitado"
      request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to new_user_session_path )
      return false
    end
  end

  helper_method :current_section
  def current_section
    Section.find_by_name(params[:section_name]) rescue nil
  end

  helper_method :current_page
  def current_page
    Page.find_by_name(params[:page_name]) rescue nil
  end

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :pass

end

