class PeopleController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  def edit
    @user = current_user
    @person = Person.find_by_user_id(current_user.id) || Person.new(:user_id => current_user.id)
  end

  def create
    @person   = Person.find_by_user_id(params[:person][:user_id])
    @person ||=  Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to profile_path }
        format.xml { head :ok }
      else
        format.html { render edit_profile_path }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find_by_user_id(current_user.id)

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

