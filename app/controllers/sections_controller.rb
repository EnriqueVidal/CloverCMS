class SectionsController < ApplicationController

  uses_yui_editor :only => :new_page  
  before_filter :check_authentication, 
                :check_authorization
  
  def items
    @section = Section.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false}
    end
  end
  
  def new_page
    @section = Section.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  def new
    @section = Section.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @section }
    end
  end

  def edit
    @section = Section.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @section = Section.find(params[:section][:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to :controller => :manager, :action => :index }
      format.xml  { head :ok }
    end
  end
end
