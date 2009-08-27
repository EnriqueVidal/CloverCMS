class ManagerController < ApplicationController

  uses_yui_editor
  
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
  
  def seo
    @metatags = MetaTag.paginate :page => params[:page], :per_page => 5
    
    respond_to do |format|
      format.html
      format.js {
       render :update do |page|
         page.replace_html 'metatags_grid', :partial => 'meta_tags/metatags_list'
       end
      }
    end
  end
  
end
