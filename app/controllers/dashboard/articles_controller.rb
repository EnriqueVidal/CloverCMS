class ArticlesController < ApplicationController
  before_filter :check_authorization, :except => [ :show ]
  before_filter :set_article, :only => [ :edit, :update, :destroy ]

  layout 'manager/manager'

  def index
    @articles    = current_user.articles.paginate :page => params[:page], :per_page => 5 unless current_user.admin?
    @articles  ||= Article.paginate     :page => params[:page], :per_page => 5
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(params[:article].except('keywords'))
    @article.keyword_list = params[:article][:keywords] if params[:article][:keywords].present?
    
    if @article.save
      redirect_to articles_path, :notice => 'Post successfully created.'
    else
      render :new
    end
  end

  def update
    @article.keyword_list = params[:article][:keywords] if params[:article][:keywords].present?
    
    if @article.update_attributes(params[:article].except(:keywords))
      redirect_to articles_path, :notice => 'Post successfully updated.'
    else
      render :edit
    end
  end

  def destroy    
    @article.destroy 
    redirect_to articles_path
  end

  private 
  
  def set_article
    @article   = current_user.articles.find(params[:id]) unless current_user.admin?
    @article ||= Article.find(params[:id])
  end
end