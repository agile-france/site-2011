source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

gem 'rails', '>= 3.0.0'
gem 'arel',  '>= 0.4.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# views
gem 'haml'
gem 'haml-rails'

# devise
gem 'devise', '>= 1.1.2'

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid', '>= 2.0.0.beta.19'
gem 'bson_ext', '>= 1.0.9'
gem 'mongo', '>= 1.0.9'

group :development, :test do
  gem "rspec-rails", ">= 2.0.0"
  
  # following statement : gem 'ruby-debug19', :platforms => :mri_19
  # does not work with bundler-1.0.0
  # heroku is using bundler-1.0.0, as of 14/10/2010  
  # TODO replace this clumsy statements with dsl
  if RUBY_VERSION =~ /^1\.9/
    gem 'ruby-debug19'
  else
    gem 'ruby-debug'
  end
end

group :test do
  gem "rspec_tag_matchers"
  gem 'wrong', '>= 0.4.0'

  # factory
  gem 'fabrication'

  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'

  # spork, drb server
  gem 'spork', '>= 0.9.0.rc2'

  # capybara
  gem 'capybara'
  gem 'launchy'
  
  # watchr is an alternate to autotest ...
  gem 'watchr'

  # rr
  gem 'rr'

  # coverage
  gem 'simplecov', :platforms => :mri_19, :require => false
end