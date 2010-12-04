class Articles::NewsController < ApplicationController
  before_filter :check_authorization, :except => [ :show ]
  before_filter :set_news, :only => [ :edit, :update, :destroy ]
  
  def new
    @news = current_user.news.new
  end
  
  private
  
  def set_news
    @news = Articles::News.find(params[:id])
  end
end