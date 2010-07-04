# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base  
  layout 'application'
  helper :all
  helper_method :referer, :current_section, :current_page, :current_article, :current_controller, :permalink
  protect_from_forgery 


  def check_authorization
    unless !current_user.nil? && (current_user.admin? || current_user.roles.detect do |role| 
      role.rights.detect  do |right| 
        right.action == action_name && right.controller ==  self.class.controller_path
        end 
      end )

      flash[:notice] = "No estas autorizado para ver la pagina que haz solicitado"
      request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to new_user_session_path )
      return false
    end
  end

  def referer
    request.env["HTTP_REFERER"]
  end

  def current_section
    Section.find_by_name(params[:section_name]) rescue nil
  end

  def current_page
    Page.find_by_name(params[:page_name]) rescue nil
  end
  
  def current_article
    if params[:username].present?
      Article.find_by_name(params[:article_name]) rescue nil
    end
    nil
  end

  def current_controller
    params[:controller]
  end

  def permalink
    'http://' + request.host + request.request_uri
  end
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :pass

end

