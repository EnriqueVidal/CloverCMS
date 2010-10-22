class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications.all if current_user
  end

  def create
    auth      = request.env["omniauth.auth"]
    email     = auth["extra"]["user_hash"]["email"]
    username  = auth["user_info"]["nickname"]
    
    render :text => auth.to_yaml
=begin
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    
    if authentication
      flash[:notice] = 'Signed in successfully.'
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
      flash[:notice] = 'Authentication successful.'
      redirect_to authentications_url
    else
      user = User.find_or_initialize_by_email(email)
      user.username = username if user.new_record?
      user.apply_omniauth(auth)
      if user.save
        flash[:notice] = 'Signed in successfully.'
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = auth.except('extra')
        redirect_to new_user_registration_url
      end
    end
=end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
