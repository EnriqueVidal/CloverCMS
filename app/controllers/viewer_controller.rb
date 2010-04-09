class ViewerController < ApplicationController
  layout 'website'
  
  def home_page
    main_page = Page.find_by_main_page(true)
    redirect_to show_section_page_path( main_page.pageable.name, main_page.name )
  end

  def show_section_page
    @section    = Section.find_by_name(params[:section_name])
    @subsection = @section.subsections.find_by_name(params[:subsection_name]) if params[:subsection_name].present?
    
    if @subsection.present?
      @page = @subsection.pages.find_by_name(params[:page_name]) rescue nil
    else
      @page = @section.pages.find_by_name(params[:page_name]) rescue nil
    end
    
    render :file => 'public/404.html' if @page.blank?
    
    @contact  = get_contact_forms
  end
  
  def get_contact_forms
    @contact_form = ContactForm.new
    render_to_string( :partial => 'contact_forms/contact_form') if !@page.nil? && @page.has_contact
  end
end

