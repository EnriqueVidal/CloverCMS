class Articles::PostsController < ApplicationController
  before_filter :check_authorization, :except => [ :show ]
  before_filter :set_post, :only => [ :edit, :update, :destroy ]
  
  layout 'manager/manager'
  
  def index
    @posts    = current_user.posts.paginate :page => params[:page], :per_page => 5 unless current_user.admin?
    @posts  ||= Articles::Post.paginate :page => params[:page], :per_page => 5
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = current_user.posts.new(params[:articles_post].except('keywords'))
    @post.keyword_list = params[:articles_post][:keywords] if params[:articles_post][:keywords].present?
    
    if @post.save
      redirect_to articles_posts_path, :notice => 'Post successfully created.'
    else
      render :new
    end
  end

  def update
    @post.keyword_list = params[:articles_post][:keywords] if params[:articles_post][:keywords].present?
    
    if @post.update_attributes(params[:articles_post].except(:keywords))
      redirect_to articles_posts_path, :notice => 'Post successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy    
    @post.destroy 
    redirect_to articles_posts_path
  end
  
  private 
  
  def set_post
    @post   = current_user.posts.find(params[:id]) unless current_user.admin?
    @post ||= Articles::Post.find(params[:id])
  end
end