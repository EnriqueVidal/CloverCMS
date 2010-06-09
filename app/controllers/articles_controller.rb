class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :check_authorization, :except => [ :index, :show ]
  uses_tiny_mce :only => [ :edit, :new, :show ], :options => {
                                                  :theme  => 'advanced',
                                                  :skin   => 'o2k7',
                                                  :plugins => %w( media print emotions searchreplace inlinepopups safari flash )
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
    @article  = Article.find_by_name(params[:article_name])
    @comments = @article.comments.paginate(:page => params[:page], :per_page => 5, :order => "created_at DESC")
    
    respond_to do |format|
      format.html { render :layout => "website" }
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    2.times { @article.photos.build }
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id]) if current_user.admin?
    @article = current_user.articles.find(params[:id])
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
    logger.info ">>> IN METHOD <<<"
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(sections_path, :notice => 'Article was successfully updated.') }
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
