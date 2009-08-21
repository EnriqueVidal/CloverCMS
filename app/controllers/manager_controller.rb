class ManagerController < ApplicationController

  uses_yui_editor
  before_filter :check_authentication, :check_authorization
  
  def index
    @sections = Section.paginate :page => params[:page], :per_page => 15
    
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace_html 'results', :partial => 'sections/search_results'
        end
      }
    end
  end
  
end
