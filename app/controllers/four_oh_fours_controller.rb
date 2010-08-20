class FourOhFoursController < ApplicationController
  layout 'website'
  
  def index
    FourOhFour.add_request(request.host, request.path, request.env['HTTP_REFERER'] || '') unless request.path =~ /^\/four_oh_fours\/{0,1}$/
    
    respond_to do |format|
      format.html { render :action => :index, :status => "404 Not Found" }
      format.all  { render :nothing => true,  :status => "404 Not Found"}
    end
  end
end
