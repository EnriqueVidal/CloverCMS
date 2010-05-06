class SectionsController < ApplicationController
  before_filter :check_authentication :check_authorization
  
  def index
    @sections = Section.paginate_and_sort(params[:page], params[:sort])

    if request.xhr?
      return render :partial => 'sections'
    end
  end

  def new
    @section            = Section.new
    @select_collection  = Section.all.collect { |section| [ section.title, section.id ] }

    respond_to do |format|
      format.html
      format.xml  { render :xml => @section }
    end
  end

  def edit
    @section            = Section.find(params[:id])
    @select_collection  = Section.all(:conditions => "id != #{@section.id}").collect { |section| [ section.title, section.id ] }

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
        format.html { redirect_to :action => :index }
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

