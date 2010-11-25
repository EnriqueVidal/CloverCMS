class Articles::NewsController < ApplicationController
  def new
    @news = current_user.news.new
  end
end