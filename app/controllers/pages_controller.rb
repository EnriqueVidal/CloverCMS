class PagesController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  uses_tiny_mce :only => [:edit, :new, :create, :update ], :options => {
                                                                        :theme    => 'advanced',
                                                                        :skin     => 'o2k7',
                                                                        :plugins  => %w(  emotions searchreplace inlinepopups safari )
                                                                      }

  def index
    @section  = Section.find( params[:section_id] )
    @pages    = @section.pages.paginate(:page => params[:page])
  end

  def new
    if params[:section_id].present?
      @section    = Section.find(params[:section_id] )    rescue nil
      @page       = @section.pages.new if @section
      @metatags   = MetaTag.all
      
      @page.photos.build
      @page.documents.build
    else
      redirect_to select_owner_page_path
    end
  end

  def select_owner
    @sections     = Section.all
  end

  def edit
    @page       = Page.find(params[:id])
    @metatags   = MetaTag.all
    @section    = @page.section

    @page.photos.build
    @page.documents.build
  end

  def create
    @section  = Section.find( params[:section_id] ) rescue nil
    @page     = @section.pages.build( params[:page] ) if @section
    @metatags = MetaTag.all

    respond_to do |format|
      if @section && @page.save
        flash[:success] = 'Page was successfully created.'
        format.html { redirect_to (@page.uploads.count >= 1) ? edit_page_path(@page) : section_pages_path(@section) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page     = Page.find(params[:id])
    @metatags = MetaTag.all
    @section  = @page.section

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to edit_page_path @page }
        format.xml  { head :ok }
      else
        format.html { render :action  => :edit }
        format.xml  { render :xml     => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page   = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      flash[:success] = 'Page was successfully removed.'
      format.html { redirect_to sections_path }
      format.xml  { head :ok }
    end
  end
end

