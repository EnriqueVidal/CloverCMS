class PhotosController < ApplicationController
  def destroy    
    @upload   = Photo.find(params[:id])
    @related  = @upload.uploadable

    if @upload.destroy
      redirect_to send(("edit_" + @related.class.to_s.downcase + "_path").to_sym, @related)
    end
  end

end