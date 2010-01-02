class ManagerController < ApplicationController

  def index
    redirect_to :controller => :pages, :action => :index
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

