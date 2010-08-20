class MetaTagsController < ApplicationController
  before_filter :authenticate_user!, :check_authorization

  def index
    @meta_tags = MetaTag.paginate( :page => params[:page], :per_page => 15 )
  end

  def new
    @meta_tag = MetaTag.new
  end

  def edit
    @meta_tag = MetaTag.find( params[:id] )
  end


  def create
    @meta_tag = MetaTag.new( params[:meta_tag] )

    respond_to do |format|
      if @meta_tag.save
        flash[:success] = 'MetaTag was successfully created.'
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @meta_tag = MetaTag.find(params[:id])

    respond_to do |format|
      if @meta_tag.update_attributes(params[:meta_tag])
        flash[:notice] = 'MetaTag was successfully updated.'
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @meta_tag = MetaTag.find(params[:id])
    @meta_tag.destroy

    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.xml  { head :ok }
    end
  end
end

