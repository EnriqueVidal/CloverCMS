class UploadsController < ApplicationController
  before_filter :check_authentication, :check_authorization
  
  def get_uploads
    @page       = Page.find( params[:page_id] )
    @photos     = @page.photos
    @documents  = @page.documents


    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create
    @uploadable = find_uploadable
    @upload     = @uploadable.photos.build(params[:upload])     if upload_type == 'image'
    @upload     = @uploadable.documents.build(params[:upload])  if upload_type == 'application'

    @page       = @upload.uploadable

    responds_to_parent do
      if @upload.save
        
        @photos    = @page.photos
        @documents = @page.documents
        
        render :update do |page|
           page.replace_html 'uploads_container', :partial => 'get_uploads'
         end
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @page    = @upload.uploadable

    responds_to_parent do
      if @upload.destroy
        @photos     = @page.photos
        @documents  = @page.documents
        render(:update){ |page| page.replace_html 'uploads_container', :partial => 'get_uploads'}
      end
    end
  end

  private

  def upload_type
    content_type  = params[:upload][:upload].content_type.split('/')[0].downcase
  end
  
  def find_uploadable
    params.each do |name, value|
      return $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

end

