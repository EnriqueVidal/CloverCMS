class SectionsController < ApplicationController

  def index
    @sections = Section.paginate :page => params[:sections_page], :per_page => 15

    respond_to do |format|
      format.html
      format.xml { render :xml => @sections }
    end
  end

  def show
    @section      = Section.find(params[:id])
    @pages        = @section.pages.paginate       :page => params[:section_pages_page], :per_page => 15
    @subsections  = @section.subsections.paginate :page => params[:subsections_page],   :per_page => 15
  end

  def new
    @section = Section.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @section }
    end
  end

  def edit
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to new_section_page_path(@section) }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to @section }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.xml  { head :ok }
    end
  end
end

