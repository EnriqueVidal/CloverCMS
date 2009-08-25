class UploadsController < ApplicationController

  def get_photos 
    @uploads  = Upload.find_all_by_page_id params[:page_id]
    @page     = Page.find(params[:page_id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @upload = Upload.new(params[:upload])
    
    respond_to do |format|
      if @upload.save
        flash[:notice] = 'Upload was successful.'
        format.html { redirect_to :controller => :manager, :action => :index }
        format.xml { head :ok }
      end
    end
  end
  
  def edit
    @upload = Upload.find(params[:id])
  end

  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        flash[:notice] = 'Upload was successfully updated.'
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to :controller => :manager, :action => :index }
      format.xml  { head :ok }
    end
  end

end
