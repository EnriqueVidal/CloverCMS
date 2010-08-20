class ContactMailer < ActionMailer::Base
  
  def contact_email(contact_form)
    
    recipients    contact_form.email
    from          'dont-reply@cloverinteractive.com'
    subject       'Mensaje desde la forma de contacto'
    sent_on       Time.now
    body({ :contact_form => contact_form })
    content_type  "text/html"
  end
end
