class PagesController < ApplicationController

  uses_yui_editor :only => :edit

  def show
    @page = Page.find(params[:id])
   
    respond_to do |format|
      format.html
      format.js { render 'ajax_page', :layout => false }
    end
  end

  def edit
    @page   = Page.find(params[:id])
    @metas  = MetaTag.all
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:page][:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to :controller => :manager, :action => :index  }
        format.xml  { head :ok }
      else
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      flash[:success] = 'Page was successfully removed.'
      format.html { redirect_to :controller => :manager, :action => :index }
      format.xml  { head :ok }
    end
  end
end
