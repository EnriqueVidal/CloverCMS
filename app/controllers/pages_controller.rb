class PagesController < ApplicationController
  before_filter :set_section
  layout 'website/website'

  # GET /:section_name/:page_name.html
  # GET /:section_name/:subsection_name/:page_name.html
  def show
    if @page.blank?
      @page   = @subsection.pages.find_by_url_name params[:page_name] if @subsection.present?
      @page ||= @section.pages.find_by_url_name params[:page_name]
    end
  end

  private

  def set_section
    if params[:section_name]
      @section    = Section.find_by_url_name params[:section_name]
      @subsection = @section.subsections.find_by_url_name params[:subsection_name]
    elsif params[:home_page]
      @page       = Page.published.home_page
      @section    = @page.section
    end
  end
end
