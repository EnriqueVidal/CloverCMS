class MetaTagsController < ApplicationController
  # GET /meta_tags
  # GET /meta_tags.xml
  def index
    @meta_tags = MetaTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meta_tags }
    end
  end

  # GET /meta_tags/1
  # GET /meta_tags/1.xml
  def show
    @meta_tag = MetaTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meta_tag }
    end
  end

  # GET /meta_tags/new
  # GET /meta_tags/new.xml
  def new
    @meta_tag = MetaTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meta_tag }
    end
  end

  # GET /meta_tags/1/edit
  def edit
    @meta_tag = MetaTag.find(params[:id])
  end

  # POST /meta_tags
  # POST /meta_tags.xml
  def create
    @meta_tag = MetaTag.new(params[:meta_tag])

    respond_to do |format|
      if @meta_tag.save
        flash[:notice] = 'MetaTag was successfully created.'
        format.html { redirect_to(@meta_tag) }
        format.xml  { render :xml => @meta_tag, :status => :created, :location => @meta_tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meta_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meta_tags/1
  # PUT /meta_tags/1.xml
  def update
    @meta_tag = MetaTag.find(params[:id])

    respond_to do |format|
      if @meta_tag.update_attributes(params[:meta_tag])
        flash[:notice] = 'MetaTag was successfully updated.'
        format.html { redirect_to(@meta_tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meta_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_tags/1
  # DELETE /meta_tags/1.xml
  def destroy
    @meta_tag = MetaTag.find(params[:id])
    @meta_tag.destroy

    respond_to do |format|
      format.html { redirect_to(meta_tags_url) }
      format.xml  { head :ok }
    end
  end
end
