class UsersController < ApplicationController

  def index
    @users = User.paginate_and_sort params[:page], params[:sort]

    return render :partial => 'users' if request.xhr?
  end

  def change_password
    if request.post?
      @user = current_user
      @user.update_attributes(params[:user])
      @user.token, @user.token_expiry = nil
      if @user.save!
        flash[:notice] = "The changes have been successfully saved."
        redirect_to :profile
      end
    end
  end

  def show
    @user = User.find_by_username(params[:username])
  end

  def register
    @user = User.new

    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:success] =  "User #{@user.username} created. Please check your inbox for activation instructions."

        format.html { redirect_to :action => :login }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => :register }
        format.xml  { render :xml, @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def activate
    @user = User.find_by_token(params[:token])
    if @user && @user.activate
      session[:user_id] = @user.id

      if @user.activation_date.nil?
        flash[:success] = "Account for #{@user.email} activated"
        redirect_to :action => :profile
      else
        if Time.now <= @user.token_expiry
          flash[:success] = "Please change your password"
          redirect_to :action => :change_password
        else
          reset_session
          flash[:error] = "The token you used has already expired please, request a new one."
          redirect_to :action => :lost_password
        end
      end
    else
      flash[:error] = "The token you tried is not valid."
      redirect_to :action => :register
    end
  end

  def lost_password
    if request.post?
      user    = User.find_by_username(params[:email_or_username])
      user  ||= User.find_by_password(params[:email_or_username])

      if user
        user.make_token
        user.token_expiry = Time.now + 1.days
        user.save!

        UserMailer.deliver_password_recovery(user)

        flash[:notice] = "An Email has just been sent to #{user.email}"
        redirect_to :action => :login
      else
        flash[:notice] = "The username or email you entered are invalid."
      end

    end
  end

  def login
    if request.post?
      user = User.authenticate(params[:email_or_username], params[:pass])
      if user

        session[:user_id] = user.id

        logger.info( "\t\t\t>>>>> INFO #{Time.now} login OK <<<<< " +
                      "id #{request.session_options[:id]} " +
                      "as user #{User.find(session[:user_id]).email}"
                    )

        logger.info "<<<<<<" + session.inspect + ">>>>>"
        if !session[:intended_action].nil? && !session[:intended_controller].nil?
            redirect_to :controller => session[:intended_controller], :action => session[:intended_action]
        else
          redirect_to( :controller => :users, :action => :profile )
        end

      else
        flash[:error] = "Username or password incorrect."
        logger.warn( "\t\t\t>>>>> WARN #{Time.now} login FAILED for user #{params[:email]} <<<<< \n")
        redirect_to(:action => :login)
      end
    end
  end

  def logout
    if logged_in?
      user = current_user

      logger.info(  "\t\t\t>>>>> INFO #{Time.now} logout OK <<<<< " +
                    "person #{user.person.full_name} " +
                    "as user #{user.username}"
                  )
    else
      logger.warn("\t\t\t>>>>> WARN #{Time.now} logout FAILED <<<<< \n")
    end
    reset_session
    flash.discard(:reset_password_token)
    redirect_to login_path
  end

  def profile
    @user = current_user
    @person = @user.person
  end

  private

  def init_session
    session[:user_id] = nil
  end


end

