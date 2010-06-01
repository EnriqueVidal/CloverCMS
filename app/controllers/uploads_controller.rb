class UploadsController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  def get_uploads
    @related    = params[:related_type].classify.constantize.find(params[:related_id])
    @photos     = @related.photos
    @documents  = @related.documents

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def create    
    @uploadable   = find_uploadable
    @upload       = @uploadable.photos.build(params[:upload])     if upload_type == 'image'
    @upload     ||= @uploadable.documents.build(params[:upload])

    @related    = @upload.uploadable

    responds_to_parent do
      if @upload.save

        @photos    = @related.photos
        @documents = @related.documents

        render :update do |page|
           page.replace_html 'uploads_container', :partial => 'get_uploads'
         end
      end
    end
  end

  private

  def upload_type
    content_type  = params[:upload][:upload].content_type.split('/')[0].downcase rescue nil
  end

  def find_uploadable
    params.each do |name, value|
      return $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

end

