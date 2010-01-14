class UploadsController < ApplicationController

  def get_photos
    @page     = Page.find( params[:page_id] )
    @uploads  = @page.photos


    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create    
    @upload   = check_for_photos
    @page     = @upload.page

    responds_to_parent do
      if @upload.save
        @uploads  = @page.uploads.find_all_by_type 'Photo'
        render :update do |page|
           page.replace_html 'image_container', :partial => 'get_photos'
         end
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    page    = @upload.page

    @upload.destroy

    respond_to do |format|
      format.html { redirect_to edit_page_path(page) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def check_for_photos
    content_type  = params[:upload][:upload].content_type.split('/')[1].downcase
    images        = %w( png jpg jpeg gif png )
    
    return Photo.new(params[:upload]) if images.include? content_type
    return Document.new(params[:upload])
  end
end

