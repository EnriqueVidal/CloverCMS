class ViewerController < ApplicationController

  layout 'website'
 
  def index
    redirect_to show_section_page_path( :section_name => Section.first.name, :page_name => Section.first.pages.first.name )
  end
 
  def show_section_page
    @page     = nil
    @section  = Section.find_by_name(params[:section_name])
    
    @section.pages.each { |page| @page = page if page.name = params[:page_name] }
  end
  
end
