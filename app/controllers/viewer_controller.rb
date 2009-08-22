class ViewerController < ApplicationController

  layout 'website'
 
  def index
    redirect_to show_section_page_path( :section_name => Section.first.name, :page_name => Section.first.pages.first.name )
  end
 
  def show_section_page
    @section  = Section.find_by_name(params[:section_name])
    @page     = @section.pages.find_by_name(params[:page_name])
  end
  
  def show_subsection_page
    @section    = Section.find_by_name(params[:section_name])
    @subsection = @section.subsections.find_by_name(params[:subsection_name])
    @page       = @subsection.pages.find_by_name(params[:page_name])
  end
end
