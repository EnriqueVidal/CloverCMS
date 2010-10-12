class PagesController < ApplicationController
  before_filter :check_authorization, :except => [ :show ]
  before_filter :set_section
  layout        'manager/manager'

  # GET /pages
  def index
    @pages = @section.pages.paginate :page => params[:page], :per_page => 5
  end

  # GET /:section_name/:page_name.html
  # GET /:section_name/:subsection_name/:page_name.html
  def show
    if @page.blank?
      @page   = @subsection.pages.find_by_url_name  params[:page_name]   if @subsection.present?
      @page ||= @section.pages.find_by_url_name     params[:page_name]
    end

    render :layout => 'website/website'
  end

  # GET /pages/new
  def new
    @page = @section.pages.new
  end

  # GET /pages/1/edit
  def edit
    @page = @section.pages.find(params[:id])
  end

  # POST /pages
  def create
    @page = @section.pages.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to(section_pages_path(@section), :notice => 'Page was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /pages/1
  def update
    @page = @section.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(section_pages_path(@section), :notice => 'Page was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /pages/1
  def destroy
    @page     = @section.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(section_pages_path(@section)) }
    end
  end
  
  private
  
  def set_section
    if params[:section_name]
      @section    = Section.find_by_url_name params[:section_name]
      @subsection = @section.subsections.find_by_url_name params[:subsection_name]
    elsif params[:home_page]
      @page       = Page.published.home_page
      @section    = @page.section
    else
      @section    = Section.find params[:section_id] rescue nil
    end
  end
end
