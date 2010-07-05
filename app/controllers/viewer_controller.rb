class ViewerController < ApplicationController
  layout 'website'
  uses_sexy_bookmarks :only => [ :show_article ]
  uses_tiny_mce       :only => [ :show_article ], :options => { :theme  => 'simple', :skin   => 'o2k7' }
  
  def home_page
    main_page = Page.find_by_main_page(true)
    redirect_to show_section_page_path( main_page.section.name, main_page.name )
  end

  def show_article
    user      = User.find_by_username( params[:username] )
    @article  = user.articles.find_by_name( params[:article_name] )                                               if user.present?
    @comments = @article.comments.paginate( :page => params[:page], :per_page => 5, :order => "created_at DESC" ) if @article.present?
    
    if @article.blank?
      FourOhFour.add_request(request.host, request.path, request.env['HTTP_REFERER'] || '')
      render 'four_oh_fours/index'
    end
  end
  
  def show_section_page
    @section    = Section.find_by_name(params[:section_name])
    @subsection = @section.subsections.find_by_name(params[:subsection_name]) if params[:subsection_name].present?
    
    if @subsection.present?
      @page = @subsection.pages.find_by_name(params[:page_name]) rescue nil
    else
      @page = @section.pages.find_by_name(params[:page_name]) rescue nil
    end
    
    if @page.blank? 
      FourOhFour.add_request(request.host, request.path, request.env['HTTP_REFERER'] || '')
      render 'four_oh_fours/index'
    end
    
    @contact  = get_contact_forms
  end
  
  def get_contact_forms
    @contact_form = ContactForm.new
    render_to_string( :partial => 'contact_forms/contact_form') if !@page.nil? && @page.has_contact
  end
end

