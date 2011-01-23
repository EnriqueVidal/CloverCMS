class Dashboard::PagesController < ApplicationController
  before_filter :check_authorization, :set_section
  layout 'dashboard'

  set_tab :list_pages, :only => :index
  set_tab :new_page, :only => :new

  # GET /pages
  def index
    @pages = @section.pages.paginate :page => params[:page], :per_page => 5
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

    respond_to do |format|
      if @page.save
        flash[:notice] = t('messages.created_successfully')
        format.html { redirect_to dashboard_section_pages_path(@section) }
      else
        format.html { render :action => :new }
      end
    end
  end

  # PUT /pages/1
  def update
    @page = @section.pages.find(params[:id])
    @page.keyword_list = params[:page][:keywords] if params[:page][:keywords].present?

    respond_to do |format|
      if @page.update_attributes params[:page].except('keywords')
        flash[:notice] = t('messages.updated_successfully')
        format.html { redirect_to dashboard_section_pages_path(@section) }
      else
        format.html { render :action => :edit }
      end
    end
  end

  # DELETE /pages/1
  def destroy
    @page = @section.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_section_pages_path(@section) }
    end
  end

  private
  def set_section
    @section ||= Section.find params[:section_id]
  end
end
