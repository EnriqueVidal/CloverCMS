class PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  access_control do
    allow all
  end

  # GET /:section/:page
  # GET /:section/:subsection/:page
  def show
    @page ||= subsection.pages.published.find_by_url_name params[:page] if subsection
    @page ||=    section.pages.published.find_by_url_name params[:page] if section

    raise Clover::PageNotFoundError if @page.blank?

    if @page.has_contact?
      @contact_form = render_to_string(:partial => 'contact_forms/contact_form', :object => ContactForm.new)
    end
  end

  #GET /
  def home
    @page     = Page.published.home_page
    @section  = @page.section
    render :show
  end

  private
  def subsection
    @subsection ||= Section.find_by_url_name params[:subsection]
  end

  def section
    @section ||= @subsection.main_section if @subsection
    @section ||= Section.find_by_url_name params[:section] if params[:subsection].blank?
  end
end
