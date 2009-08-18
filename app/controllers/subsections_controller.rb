class SubsectionsController < ApplicationController
  # GET /subsections
  # GET /subsections.xml
  def index
    @subsections = Subsections.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subsections }
    end
  end

  # GET /subsections/1
  # GET /subsections/1.xml
  def show
    @subsections = Subsections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subsections }
    end
  end

  # GET /subsections/new
  # GET /subsections/new.xml
  def new
    @subsections = Subsections.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subsections }
    end
  end

  # GET /subsections/1/edit
  def edit
    @subsections = Subsections.find(params[:id])
  end

  # POST /subsections
  # POST /subsections.xml
  def create
    @subsections = Subsections.new(params[:subsections])

    respond_to do |format|
      if @subsections.save
        flash[:notice] = 'Subsections was successfully created.'
        format.html { redirect_to(@subsections) }
        format.xml  { render :xml => @subsections, :status => :created, :location => @subsections }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subsections.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subsections/1
  # PUT /subsections/1.xml
  def update
    @subsections = Subsections.find(params[:id])

    respond_to do |format|
      if @subsections.update_attributes(params[:subsections])
        flash[:notice] = 'Subsections was successfully updated.'
        format.html { redirect_to(@subsections) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subsections.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subsections/1
  # DELETE /subsections/1.xml
  def destroy
    @subsections = Subsections.find(params[:id])
    @subsections.destroy

    respond_to do |format|
      format.html { redirect_to(subsections_url) }
      format.xml  { head :ok }
    end
  end
end
