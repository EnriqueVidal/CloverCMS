class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :create ]
  
  def index
    @authentications = current_user.authentications.all if current_user
  end

  def create
    auth    = request.env["omniauth.auth"]
    email   = auth['extra']['user_hash']['email'] rescue nil
    email ||= auth['user_info']['email']          rescue nil
    
    authentication  = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    user            = User.find_by_email(email) if email.present? && current_user.blank?
    
    if authentication
      sign_in_and_redirect(:user, authentication.user, :notice => 'Signed in successfully.')
    elsif user
      user.apply_omniauth(auth)
      session[:omniauth]  = auth.except('extra')
      session[:email]     = email
      
      sign_in_and_redirect(:user, user)
    elsif current_user
      current_user.authentications.with_auth(auth['provider'], auth['uid'])
      redirect_to authentications_url, :notice => 'Authentication succesful'
    else
      user  = User.find_or_initialize_by_email(email || '')
      user.apply_omniauth(auth)
      if user.save
        sign_in_and_redirect(:user, user, :notice => 'Signed in successfully')
      else
        session[:omniauth]  = auth.except('extra')
        session[:email]     = email
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
