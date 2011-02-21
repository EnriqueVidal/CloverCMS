class ContactFormsController < ApplicationController
  def create
    @contact_form = ContactForm.new params[:contact_form]

    if @contact_form.valid?
      flash[:success] = t 'messages.email_sent'
      redirect_to root_path
    else
      flash[:error] = t 'messages.failed_miserably'
      redirect_to request.env["HTTP_REFERER"]
    end
  end
end
