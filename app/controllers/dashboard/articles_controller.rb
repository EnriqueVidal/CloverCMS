class Dashboard::ArticlesController < ApplicationController
  before_filter :check_authorization
  before_filter :set_article, :only => [ :destroy, :edit, :update ]

  layout 'dashboard'

  set_tab :list_articles, :only => :index
  set_tab :new_article, :only => :new

  def index
    @articles = current_user.articles.page params[:page] unless current_user.admin?
    @articles ||= Article.page params[:page]
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(params[:article].except('keywords'))
    @article.keyword_list = params[:article][:keywords] if params[:article][:keywords].present?

    if @article.save
      flash[:success] = t 'messages.created_successfully'
      redirect_to dashboard_articles_path
    else
      render :new
    end
  end

  def update
    @article.keyword_list = params[:article][:keywords] if params[:article][:keywords].present?

    if @article.update_attributes(params[:article].except(:keywords))
      flash[:success] = t 'messages.updated_successfully'
      redirect_to dashboard_articles_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to dashboard_articles_path
  end

  private
  def set_article
    @article   = current_user.articles.find(params[:id]) unless current_user.admin?
    @article ||= Article.find(params[:id])
  end
end
