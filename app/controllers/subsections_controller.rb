class SubsectionsController < ApplicationController
  
  uses_yui_editor :only => :new_page
                
  def show
    @subsection = Subsection.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def items
    @subsection = Subsection.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def new_page
    @subsection = Subsection.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def add_subsection
    @subsection = Subsection.new
    @section_id = params[:section_id]
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def edit
    @subsection = Subsection.find(params[:id])
  end

  def create
    @subsection = Subsection.new(params[:subsection])

    respond_to do |format|
      if @subsection.save
        flash[:notice] = 'Subsection was successfully created.'
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { render :xml => @subsection, :status => :created, :location => @subsection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @subsection = Subsection.find(params[:subsection][:id])

    respond_to do |format|
      if @subsection.update_attributes(params[:subsection])
        flash[:notice] = 'Subsection was successfully updated.'
        format.html { redirect_to(@subsection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @subsection = Subsection.find(params[:id])
    @subsection.destroy

    respond_to do |format|
      format.html { redirect_to :controller => :manager, :action => :index }
      format.xml  { head :ok }
    end
  end
end
