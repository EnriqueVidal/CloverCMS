class PagesController < ApplicationController

  uses_tiny_mce :only => [:edit, :new], :options => {
                                                  :theme  => 'simple',
                                                  :skin   => 'o2k7'
                                                }

  def index
    @pages = Page.paginate_and_sort_by_section_or_subsection(params[:page], params[:sort], params[:section_id], params[:subsection_id])
    
    return render :partial => 'pages' if request.xhr?
  end

  def new
    @page   = Page.new
    @metas  = MetaTag.all

    @page.section_id    = params[:section_id]
    @page.subsection_id = params[:subsection_id]
    
    if params[:section_id].nil? && params[:subsection_id].nil?
      @sections     = Section.all
      @subsections  = Subsection.all
    end
  end

  def edit
    @page   = Page.find(params[:id])
    @metas  = MetaTag.all
  end

  def create
    @page = Page.new(params[:page])
    
    @page.section_id    = nil if params[:page][:section_id].nil? || params[:page][:section_id].to_i == 0
    @page.subsection_id = nil if params[:page][:section_id].nil? || params[:page][:subsection_id].to_i == 0

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to (@page.uploads.count >= 1) ? edit_page_path(@page) : { :controller => :sections, :action => :index } }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        flash[:notice] = 'Please fill out all the required fields.'
        format.html { redirect_to :action => :new }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to :controller => :manager, :action => :index  }
        format.xml  { head :ok }
      else
        format.html { render :action => :update }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page       = Page.find(params[:id])

    @page.destroy

    respond_to do |format|
      flash[:success] = 'Page was successfully removed.'
      format.html { redirect_to :controller => :sections, :action => :index }
      format.xml  { head :ok }
    end
  end
end

