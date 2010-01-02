class SubsectionsController < ApplicationController

  def index
    @subsections = Subsection.paginate :page => params[:subsections_page], :per_page => 15

    respond_to do |format|
      format.html
      format.xml { render :xml => @subsections }
    end
  end

  def show
    @subsection = Subsection.find(params[:id])
    @pages      = @subsection.pages.paginate :page => params[:subsection_pages_page], :per_page => 15

    respond_to do |format|
      format.html
    end
  end

  def new
    @subsection             = Subsection.new
    @subsection.section_id  = params[:section_id]

    respond_to do |format|
      format.html
      format.xml { render :xml => @subsection }
    end
  end

  def edit
    @subsection = Subsection.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @subsection = Subsection.new(params[:subsection])

    respond_to do |format|
      if @subsection.save
        flash[:notice] = 'Subsection was successfully created.'
        format.html { redirect_to @subsection }
        format.xml  { render :xml => @subsection, :status => :created, :location => @subsection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @subsection = Subsection.find(params[:id])

    respond_to do |format|
      if @subsection.update_attributes(params[:subsection])
        flash[:notice] = 'Subsection was successfully updated.'
        format.html { redirect_to @subsection }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Something went wrong'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @subsection = Subsection.find(params[:id])
    section_id  = @subsection.section.id
    @subsection.destroy

    respond_to do |format|
      format.html { redirect_to '/sections/' + section_id.to_s }
      format.xml  { head :ok }
    end
  end
end

