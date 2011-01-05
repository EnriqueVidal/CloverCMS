class Dashboard::SectionsController < ApplicationController
  before_filter :check_authorization
  layout 'manager/manager'

  # GET /sections
  def index
    @sections = Section.paginate :page => params[:page], :per_page => 5
  end

  # GET /sections/1
  def show
    @section = Section.find(params[:id])
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to(dashboard_sections_path, :notice => 'Section was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /sections/1
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to(dashboard_sections_path, :notice => 'Section was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /sections/1
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to(dashboard_sections_path) }
    end
  end
end
