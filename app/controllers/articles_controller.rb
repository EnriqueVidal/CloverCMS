class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :check_authorization, :except => [ :index, :show ]
  uses_tiny_mce :only => [ :edit, :new ], :options => {
                                                  :theme    => 'advanced',
                                                  :skin     => 'o2k7',
                                                  :plugins  => %w( emotions inlinepopups  ),
                                                  :cleanup  => false
                                                }
  
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.paginate( :page => params[:page], :per_page => 5, :order => "created_at DESC" )

    respond_to do |format|
      format.html { render :layout => "website" }
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    article       = Article.find(params[:id]) rescue nil
    username      = article.present? ? article.user.username  : 'no_user'
    article_name  = article.present? ? article.name           : 'no_article'
    
    head :moved_permanently, :location => show_article_path( username, article_name)  
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @article.photos.build
    @article.documents.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article    = Article.find(params[:id]) if current_user.admin?
    @article  ||= current_user.articles.find(params[:id])
    
    @article.photos.build
    @article.documents.build
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(:controller => :sections, :action => :index, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to edit_article_path( @article ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
