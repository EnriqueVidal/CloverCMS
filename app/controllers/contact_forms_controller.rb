class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end
  
  def create
    @contact_form = ContactForm.new( params[:contact_form] )
    
    if verify_recaptcha( :model => @contact_form, :message => 'Recaptcha error' ) && @contact_form.valid?
      flash[:success] = "Your email has been sent."

      ContactMailer.deliver_contact_email( @contact_form )
      redirect_to root_url
    else
      flash[:error] = "You have failed to prive all the required information. Please start over."
      @contact      = Section.find_by_name('contacto')
      redirect_to params[:return_page]
    end
  end
end
