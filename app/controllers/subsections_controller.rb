class SubsectionsController < ApplicationController

  def index
    @subsections = Subsection.paginate_and_sort(params[:page], params[:sort], { :section_id => params[:section_id] })
    
    return render :partial => 'subsections' if request.xhr?
  end

  def new
    @subsection             = Subsection.new
    @subsection.section_id  = params[:section_id]
    @sections               = Section.all unless !@subsection.section_id.blank?

    respond_to do |format|
      format.html
      format.xml { render :xml => @subsection }
    end
  end

  def edit
    @subsection = Subsection.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @subsection             = Subsection.new(params[:subsection])
    @subsection.section_id  = nil if params[:subsection][:section_id].nil? || params[:subsection][:section_id].to_i == 0

    @sections = Section.all if @subsection.section_id.nil?

    respond_to do |format|
      if @subsection.save
        flash[:notice] = 'Subsection was successfully created.'
        format.html { redirect_to new_subsection_page_path( @subsection ) }
        format.xml  { render :xml => @subsection, :status => :created, :location => @subsection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @subsection = Subsection.find(params[:id])

    respond_to do |format|
      if @subsection.update_attributes(params[:subsection])
        flash[:notice] = 'Subsection was successfully updated.'
        format.html { redirect_to @subsection }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Something went wrong'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subsection.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @subsection = Subsection.find(params[:id])
    section_id  = @subsection.section.id
    @subsection.destroy

    respond_to do |format|
      format.html { redirect_to :controller => :sections, :action => :index }
      format.xml  { head :ok }
    end
  end
end

