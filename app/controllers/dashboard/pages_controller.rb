class Dashboard::PagesController < ApplicationController
  before_filter :set_section

  access_control do
    allow :admin
  end

  set_tab :list_pages, :only => :index
  set_tab :new_page, :only => :new

  # GET /pages
  def index
    @pages = @section.pages.page params[:page]
  end

  # GET /pages/new
  def new
    @page = @section.pages.new
  end

  # GET /pages/1/edit
  def edit
    @page = @section.pages.find params[:id]
  end

  # POST /pages
  def create
    @page = @section.pages.new params[:page].except('keywords')
    @page.keyword_list = params[:page][:keywords] if params[:page][:keywords].present?

    if @page.save
      flash[:success] = t 'messages.created_successfully'
      redirect_to dashboard_section_pages_path(@section)
    else
      render :action => :new
    end
  end

  # PUT /pages/1
  def update
    @page = @section.pages.find(params[:id])
    @page.keyword_list = params[:page][:keywords] if params[:page][:keywords].present?

    if @page.update_attributes params[:page].except('keywords')
      flash[:success] = t 'messages.updated_successfully'
      redirect_to dashboard_section_pages_path(@section)
    else
      render :action => :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page = @section.pages.find(params[:id])
    @page.destroy

    redirect_to dashboard_section_pages_path(@section)
  end

  private
  def set_section
    @section ||= Section.find params[:section_id]
  end
end
