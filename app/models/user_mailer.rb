class UserMailer < ActionMailer::Base
  def welcome_email(user)
    url = "http://www.cloverineractive.com/users/activate/" + user.token
    recipients    user.email
    from          "dont-reply@cloverinteractive.com"
    subject       "Bienvenido a CloverInteractive"
    sent_on       Time.now
    body({ :user => user, :url => url })
    content_type  "text/html" 
  end  
end
