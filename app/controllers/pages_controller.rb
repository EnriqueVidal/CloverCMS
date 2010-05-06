class PagesController < ApplicationController
  before_filter :check_authentication, :check_authorization

  uses_tiny_mce :only => [:edit, :new], :options => {
                                                  :theme  => 'advanced',
                                                  :skin   => 'o2k7',
                                                  :plugins => %w( media print emotions searchreplace inlinepopups safari flash )
                                                }

  def index
    lists = find_pageable true
    @pageable, @pages = lists[0], lists[1]
    return render :partial => 'pages' if request.xhr?
  end

  def new
    @pageable = find_pageable
    @page     = Page.new
    @metas    = MetaTag.all
    
    2.times do
      @page.photos.build
      @page.documents.build
    end
    
    continue = params[:section_id] || params[:subsection_id]

    if continue.nil?
      redirect_to pick_onwer_path
    elsif @pageable.nil?
      flash[:error] = "You have tried to add this page to an element that does not exist."
      redirect_to sections_path
    end
  end

  def select_owner
    @sections     = Section.all
  end

  def edit
    @page   = Page.find(params[:id])
    @metas  = MetaTag.all
  end

  def create
    @pageable = find_pageable
    @page     = @pageable.pages.build(params[:page])

    respond_to do |format|
      if @page.save
        flash[:success] = 'Page was successfully created.'
        format.html { redirect_to (@page.uploads.count >= 1) ? edit_page_path(@page) : sections_path }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        flash[:error] = 'Please fill out all the required fields.'
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
      format.html { redirect_to sections_path }
      format.xml  { head :ok }
    end
  end

  private

  def find_pageable(paginate=false)
    params.each do |name, value|
      if name =~ /(.+)_id$/ and value.to_i > 0
        type      = $1.classify
        custom    = { :pageable_id => value, :pageable_type => type }
        pageable  = type.constantize.find(value) rescue nil

        list      = [ pageable, Page.paginate_and_sort(params[:page], params[:sort], custom) ]

        return ( paginate ) ? list : list[0]
      end
    end

    return nil
  end
  
end

