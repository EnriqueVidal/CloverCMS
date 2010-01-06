class ManagerController < ApplicationController

  def index
    redirect_to :controller => :sections, :action => :index
  end

end

