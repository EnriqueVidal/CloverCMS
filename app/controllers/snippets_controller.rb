class SnippetsController < ApplicationController
    before_filter :authenticate_user!, :check_authorization

  def index
    @snippetable  = find_snippetable
    @snippets     = @snippetable.snippets.paginate(:page => params[:page], :per_page => 5) if @snippetable.present?
    @snippets   ||= Snippet.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def select_owner
    @articles = Article.all
  end
  
  def show
    @snippetable  = find_snippetable
    @snippet      = @snippetable.snippets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @snippetable  = find_snippetable

    if @snippetable.present?
      @snippet      = @snippetable.snippets.build

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @snippet }
      end
    else
      redirect_to select_owner_snippet_path
    end
  end

  def edit
    @snippetable  = find_snippetable
    @snippet      = @snippetable.snippets.find(params[:id])
  end

  def create
    @snippetable      = find_snippetable
    @snippet          = @snippetable.snippets.build(params[:snippet])
    
    respond_to do |format|
      if @snippet.save!
        format.html { redirect_to article_snippet_path(@snippetable.id, @snippet), :notice => 'Snippet creado con exito' }
        format.xml  { render :xml => @snippet, :status => :created, :location => @comment }
      else
        format.html { render :nothing => true }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @snippetable  = find_snippetable
    @snippet      = @snippetable.snippets.find(params[:id])

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to(snippetable_url, :notice => 'Snippet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def delete
    @snippet = Snippet.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @snippet      = Snippet.find(params[:id])
    @snippetable  = @snippet.snippetable
    
    redirect_to( snippetable_url ) and return if params[:cancel]
    
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to( snippetable_url, :notice => 'Comentario eliminado con exito' ) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def snippetable_url
    send( @snippetable.class.to_s.downcase + "_snippets_path", @snippetable )
  end
  
  def find_snippetable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
