ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => ENV['mailer.user_name'],
  :password => ENV['mailer.password']
}
ActionMailer::Base.default_url_options[:host] = ENV['mailer.host_url_option']
ActionMailer::Base.delivery_method = :smtp