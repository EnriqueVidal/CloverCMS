class ViewerController < ApplicationController

  layout 'website'
  
  def home_page
    redirect_to show_section_page_path( :section_name => Section.first.name, :page_name => Section.first.pages.first.name )
  end

  def show_section_page
    @section  = Section.find_by_name(params[:section_name])
    @page     = @section.pages.find_by_name(params[:page_name])
    @contact  = get_contact_forms
  end

  def show_subsection_page
    @section    = Section.find_by_name(params[:section_name])
    @subsection = @section.subsections.find_by_name(params[:subsection_name])
    @page       = @subsection.pages.find_by_name(params[:page_name])
    @contact    = get_contact_forms
  end
  
  def get_contact_forms
    @contact_form = ContactForm.new
    render_to_string( :partial => 'contact_forms/contact_form') if !@page.nil? && @page.has_contact
  end
end

