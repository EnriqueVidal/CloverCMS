begin  
  require 'tlsmail'
rescue LoadError
  puts "tlsmail not yet installed"
else

  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

  ActionMailer::Base.delivery_method        = :smtp
  ActionMailer::Base.perform_deliveries     = true
  ActionMailer::Base.default_charset        = "utf-8"
  ActionMailer::Base.raise_delivery_errors  = true
  ActionMailer::Base.smtp_settings          = {
                                                :domain          => "cloverinteractive.com",
                                                :address         => 'smtp.gmail.com',
                                                :port            => 587,
                                                :tls             => true,
                                                :authentication  => :plain,
                                                :user_name       => 'dont-reply@cloverinteractive.com',
                                                :password        => 'H@Nn@L1v3$C10v3R1N73r@kT1v3'
                                              }
end