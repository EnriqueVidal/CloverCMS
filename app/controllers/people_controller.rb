class PeopleController < ApplicationController

  in_place_edit_for :person, :first_name
  in_place_edit_for :person, :middle_name
  in_place_edit_for :person, :last_name

  def update
    @person           = User.find(session[:user_id]).person

#    params[:person]   = params[:member]
#    params[:person] ||= params[:admin]

# Commented for now but must revisit when new  geography database is implemented
#    params[:person][:city_id]         = nil if !params[:person][:postal_code_id].nil?
#    params[:person][:postal_code_id]  = nil if !params[:person][:city_id].nil?

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to :controller => :users, :action => :profile }
        format.xml  { head :ok }
      else
        format.html { render :controller => :users, :action => :profile }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

end

