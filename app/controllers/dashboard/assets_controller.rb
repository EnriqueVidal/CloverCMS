class Dashboard::AssetsController < ApplicationController
  before_filter :fix_content_type, :check_authorization

  def create
    @asset = Asset.new :attachable_type => params[:attachable_type], :attachable_id => params[:attachable_id]
    @asset.asset = params[:Filedata]

    if @asset.save!
      success = { :status => 'success', :thumbnail => @asset.asset.url(:small) }.to_json
      render :json =>  success
    else
      render :json => { :status => 'error' }.to_json
    end
  end

  def destroy
  end

  private
  def fix_content_type
    params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename).to_s
  end
end
