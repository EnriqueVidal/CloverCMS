class ViewerController < ApplicationController
  layout 'website/website'
  
  def home
    @page       = Page.where("home_page = ?", true).where("published = ?", true).first
    @section    = @page.section         if @page
    @subsection = @section.main_section if @section
    
    render 'show_page'
  end
  
  def show_page
    @subsection = Section.where("url_name = ?", params[:subsection_name]).first                                 if params[:subsection_name].present?
    @section    = @subsection.subsections.where("url_name = ?", params[:section_name]).first                    if @subsection.present?
    @section    = Section.where("url_name = ?", params[:section_name]).first                                    if params[:subsection_name].blank?
    @page       = @section.pages.where("url_name = ?", params[:page_name]).where("published = ?", true).first   if @section.present?
    
    render '../../public/404.html', :layout => false if @page.blank?
  end
end
