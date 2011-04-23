class Dashboard::SettingsController < ApplicationController
  set_tab :list_settings, :only => :index
  set_tab :new_setting,   :only => :new

  def index
    @settings = Setting.page params[:page]
  end

  def new
    @setting = Setting.new
  end

  def edit
    @setting = Setting.find params[:id]
    @themes = get_themes if @setting.name == 'theme'
  end

  def create
    @setting = Setting.new params[:setting]

    if @setting.save
      flash[:success] = t 'messages.created_successfully'
      redirect_to dashboard_settings_path
    else
      render :action => :new
    end
  end

  def update
    @setting = Setting.find params[:id]
    params[:setting] = params[:setting].except(:name) if !@setting.destroyable?

    if @setting.update_attributes params[:setting]
      flash[:success] = t 'messages.updated_successfully'
      redirect_to dashboard_settings_path
    else
      render :action => :new
    end
  end

  def destroy
    @setting = Setting.find params[:id]

    if @setting.delete
      flash[:success] = t 'messages.deleted_successfully'
      redirect_to dashboard_settings_path
    else
      flash[:error] = t 'messages.failed_miserably'
      redirect_to dashboard_settings_path
    end
  end

  private
  def get_themes
    themes_path = File.join Rails.root, 'app', 'views', 'layouts', 'themes'

    Dir.new(themes_path).select do |dir|
      dir =~ /^[a-z0-9_-]+$/i && File.directory?( File.join themes_path, dir )
    end
  end
end
