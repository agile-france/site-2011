ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => 'thierry.henrio@gmail.com',
  :password => "gas7roll"
}
ActionMailer::Base.default_url_options[:host] = ENV['mailer.host_url_option']
ActionMailer::Base.delivery_method = :smtp