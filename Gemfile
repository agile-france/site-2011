source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

def heroku?
  ENV.any?{|k, _| k =~ /^HEROKU/} or (ENV['USER'] =~ /^repo\d+/ if ENV['USER']) 
end

gem 'rails', '>= 3.0.0'
gem 'arel',  '>= 0.4.0'

# views
gem 'haml'
gem 'haml-rails'

# devise
gem 'devise', '>= 1.1.2'

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid', '>= 2.0.0.beta.19'
gem 'mongoid_taggable', '~> 0.1'
gem 'bson_ext', '>= 1.0.9'
gem 'mongo', '>= 1.0.9'

# TODO use groups on heroku
unless heroku?
  group :development, :test do
    gem "rspec-rails", ">= 2.1.0"
    
    gem 'ruby-debug19', :platforms => :mri_19
    gem 'ruby-debug', :platforms => :mri_18
  end

  group :test do
    gem "rspec_tag_matchers"
    gem 'mongoid-rspec'
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
end