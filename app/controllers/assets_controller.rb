class AssetsController < ApplicationController
  def create
    render :json => { :status => 'success' }
  end
  
  def destroy
  end
end