class Dashboard::SiteConfigsController < ApplicationController
  before_filter :check_authorization
  layout 'dashboard'

  def edit
    @site_config = SiteConfig.last
    @themes = get_themes
  end

  def update
    @site_config = SiteConfig.last

    if @site_config.update_attributes params[:site_config]
      flash[:sucess] = t 'messages.created_successfully'
      redirect_to :action => :edit
    else
      render :edit
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
