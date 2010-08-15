class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :referer, :current_section, :current_page, :current_article, :current_controller, :current_action, :permalink
  
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
   
   def current_article
     if params[:username].present?
       user = User.find_by_username(params[:username])
       return user.articles.find_by_name(params[:article_name]) rescue nil
     end
     nil
   end

   def current_controller
     params[:controller]
   end

   def current_action
     params[:action]
   end

   def permalink
     'http://' + request.host + request.request_uri
   end
end
