source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

gem 'rails', '>= 3.0.0'
gem 'arel',  '>= 0.4.0'

gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# debugger
gem 'ruby-debug19'

# views
gem 'haml'
gem 'haml-rails'

# devise
gem 'devise', '>= 1.1.2'

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid', '>= 2.0.0.beta.18'
gem 'bson_ext', '1.0.4'

group :development do
  # rspec
  gem "rspec-rails", ">= 2.0.0.beta.22"
end

group :test do
  gem "rspec_tag_matchers"

  # factory
  gem 'factory_girl_rails'

  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'

  # spork, drb server, is banned for a while, till integration is better
  # gem 'spork'

  # capybara
  gem 'capybara'
  gem 'launchy'

  # autotest
  gem 'autotest'
  gem 'autotest-growl'
  gem 'autotest-fsevent' if mac?
  
  # watchr is an alternate to autotest ...
  gem 'watchr'

  # rr
  gem 'rr'

  # coverage
  gem 'simplecov', :require => false
end
