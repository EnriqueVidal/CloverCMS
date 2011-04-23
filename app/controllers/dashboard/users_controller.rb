class Dashboard::UsersController < ApplicationController
  access_control do
    allow :admin
  end

  set_tab :list_users, :only => :index

  def index
    @users = User.order('username').page params[:page]
  end

  def destroy
    @user = User.find params[:id]

    if @user.delete
      flash[:success] = t('messages.deleted_successfully')
      redirect_to :action => :index
    end
  end
end
