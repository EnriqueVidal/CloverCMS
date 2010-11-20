class AssetsController < ApplicationController
  before_filter :fix_content_type
  
  def create
    @asset = Asset.new :attachable_type => params[:attachable_type], :attachable_id => params[:attachable_id]
    @asset.asset = params[:Filedata]
    
    if @asset.save!
      render :json => { :status => 'success' }
    else
      render :json => { :status => 'error' }
    end
  end
  
  def destroy
  end
  
  private

  def fix_content_type
    params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename).to_s
  end
end