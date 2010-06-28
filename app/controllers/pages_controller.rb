class PagesController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  uses_tiny_mce :only => [:edit, :new], :options => {
                                                  :theme    => 'advanced',
                                                  :skin     => 'o2k7',
                                                  :plugins  => %w(  emotions searchreplace inlinepopups safari )
                                                }

  def index
    @section  = Section.find( params[:section_id] )
    @pages    = @section.pages.paginate(:page => params[:page])
  end

  def new
    if ( params[:section].present? && params[:section][:id].present? ) || params[:section_id].present?
      @section    = Section.find(params[:section][:id] )  rescue nil
      @section  ||= Section.find(params[:section_id] )    rescue nil
      @page       = @section.pages.new if @section
      @metatags   = MetaTag.all
      
      @page.photos.build
      @page.documents.build
    else
      redirect_to pick_onwer_path
    end
  end

  def select_owner
    @sections     = Section.all
  end

  def edit
    @page       = Page.find(params[:id])
    @metatags   = MetaTag.all
    @section    = @page.section
  end

  def create
    @section  = Section.find( params[:section_id] ) rescue nil
    @page     = @section.pages.build( params[:page] ) if @section
    
    @page.photos.build(params[:photos])       if params[:photos].values.all?(&:present?)
    @page.documents.build(params[:documents]) if params[:documents].values.all?(&:present?)

    respond_to do |format|
      if @section && @page.save
        flash[:success] = 'Page was successfully created.'
        format.html { redirect_to (@page.uploads.count >= 1) ? edit_page_path(@page) : sections_path }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        flash[:error] = 'Please fill out all the required fields.'
        format.html { redirect_to :action => :new }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.photos.build(params[:photos])       if params[:photos].values.all?(&:present?)
    @page.documents.build(params[:documents]) if params[:documents].values.all?(&:present?)

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to edit_page_path @page }
        format.xml  { head :ok }
      else
        format.html { render :action => :update }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
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

