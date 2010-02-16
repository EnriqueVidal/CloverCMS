class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end
  
  def create
    @contact_form = ContactForm.new(params[:contact_form])
    if @contact_form.valid?
      flash[:success] = "Your email has been sent."

      ContactMailer.deliver_contact_email( @contact_form )
      redirect_to root_url
    else
      #render :action => :new
      flash[:error] = "Please fill out all the required fields."
      redirect_to referrer
    end
  end
end
