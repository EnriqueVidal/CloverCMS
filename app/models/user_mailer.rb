class UserMailer < ActionMailer::Base

  @from = 'dont-reply@cloverinteractive.com'
  
  def welcome_email(user)
    url = "http://www.cloverineractive.com/users/activate/" + user.token
    recipients    user.email
    from          "dont-reply@cloverinteractive.com"
    subject       "Bienvenido a CloverInteractive"
    sent_on       Time.now
    body({ :user => user, :url => url })
    content_type  "text/html" 
  end  
  
  def password_recovery(user)
    url = "http://www.cloverinteractive.com/users/activate/" + user.token
    recipients  user.email
    from        @from
    subject     "CloverInteractive password recovery."
    sent_on     Time.now
    body({ :user => user, :url => url })
    content_type  'text/html'
  end
end
