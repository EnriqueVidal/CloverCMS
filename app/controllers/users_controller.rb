class UsersController < ApplicationController

  def index
    @users = User.paginate_and_sort params[:page], params[:sort]
    
    return render :partial => 'users' if request.xhr?
  end
  
  def edit
    @users = User.find params[:id]
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
        flash[:success] =  "Usuario #{@user.email} creado. Por favor revisa tu bandeja de entrada."

        # Changed for now, must revisit and redirect to url.
        #format.html { redirect_to( :controller => :home, :action => :index ) }

        format.html { render "register" }
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
      flash[:success] = "Cuenta #{@user.email} activada"
      redirect_to :action => :profile
    else
      flash[:error] = "El hash utilizado para esta activación es incorrecto"
      redirect_to :action => :register
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

        if !session[:intended_action].nil? && !session[:intended_controller].nil?
            redirect_to :controller => session[:intended_controller], :action => session[:intended_action]
        else
          redirect_to( :controller => :users, :action => :profile )
        end

      else
        flash[:error] = "Información de login invalida, usuario o contraseña invalidos."
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

