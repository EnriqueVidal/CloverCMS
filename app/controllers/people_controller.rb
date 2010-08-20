class PeopleController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  def edit
    @user   = current_user
    @person = current_user.person || Person.new(:user_id => current_user.id)
  end

  def create
    @person   = current_user.person
    @person ||=  Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to profile_path }
        format.xml { head :ok }
      else
        format.html { redirect_to(profile_path, :notice => 'There has been an error while trying to save this person' ) }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @person = current_user.person

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

