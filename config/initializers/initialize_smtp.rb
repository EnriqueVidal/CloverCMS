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
                                                :domain          => "tjruby.org",
                                                :address         => 'smtp.gmail.com',
                                                :port            => 587,
                                                :tls             => true,
                                                :authentication  => :plain,
                                                :user_name       => 'dont-reply@tjruby.org',
                                                :password        => 'Sn192#*4bdhA!0'
                                              }
end