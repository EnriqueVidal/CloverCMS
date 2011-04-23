class Dashboard::SectionsController < ApplicationController
  set_tab :list_sections, :only => :index
  set_tab :new_section,   :only => :new

  access_control do
    allow :admin
  end

  # GET /sections
  def index
    @sections = Section.page params[:page]
  end

  # GET /sections/1
  def show
    @section = Section.find params[:id]
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find params[:id]
  end

  # POST /sections
  def create
    @section = Section.new params[:section]

    if @section.save
      flash[:success] = t 'messages.created_successfully'
      redirect_to dashboard_sections_path
    else
      render :action => "new"
    end
  end

  # PUT /sections/1
  def update
    @section = Section.find params[:id]

    if @section.update_attributes params[:section]
      flash[:success] = t 'messages.updated_successfully'
      redirect_to dashboard_sections_path
    else
      render :action => "edit"
    end
  end

  # DELETE /sections/1
  def destroy
    @section = Section.find params[:id]
    @section.destroy

    redirect_to dashboard_sections_path
  end
end
