class PagesController < ApplicationController

  uses_tiny_mce :only => [:edit, :new], :options => {
                                                  :theme => 'advanced',
                                                  :theme_advanced_resizing => false,
                                                  :theme_advanced_resize_horizontal => false,
                                                  :plugins => %w{ table fullscreen }
                                                }

  def index
    @section_pages    = Page.paginate :page => params[:pages_by_section_page],    :per_page => 10, :conditions => 'section_id IS NOT NULL'
    @subsection_pages = Page.paginate :page => params[:pages_by_subsection_page], :per_page => 10, :conditions => 'subsection_id IS NOT NULL'

    respond_to do |format|
      format.html
    end
  end

  def new
    if params[:section_id].nil? && params[:subsection_id].nil?
      flash[:notice] = 'All pages must belong to either one section or subsection.'
      redirect_to :controller => :sections, :action => :index
    end

    @page   = Page.new
    @metas  = MetaTag.all

    @page.section_id    = params[:section_id]
    @page.subsection_id = params[:subsection_id]
  end

  def edit
    @page   = Page.find(params[:id])
    @metas  = MetaTag.all
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to :controller => :sections, :action => :index }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        flash[:notice] = 'Page was not created.'
        format.html { redirect_to :controller => :sections, :action => :index }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

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
    @page       = Page.find(params[:id])

    @page.destroy

    respond_to do |format|
      flash[:success] = 'Page was successfully removed.'
      format.html { redirect_to :controller => :sections, :action => :index }
      format.xml  { head :ok }
    end
  end
end

