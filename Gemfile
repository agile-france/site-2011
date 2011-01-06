source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

gem 'rails', '>= 3.0.0'
gem 'arel',  '>= 0.4.0'

# views
gem 'haml'
gem 'haml-rails'
gem 'will_paginate', '~> 3'

# devise
gem 'devise', '>= 1.1.2'

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid', '>= 2.0.0.beta.19'
gem 'mongoid_taggable', '~> 0.1'
gem 'bson_ext', '>= 1.0.9'
gem 'mongo', '>= 1.0.9'

# cant
gem 'cant'

group :development, :test do
  gem "rspec-rails", ">= 2.1.0"

  # factory (required for scaffold)
  gem 'fabrication'
  
  gem 'ruby-debug19', :platforms => :mri_19
  gem 'ruby-debug', :platforms => :mri_18
end

group :test do
  gem "rspec_tag_matchers"
  gem 'mongoid-rspec'
  gem 'wrong', '~> 0.4'


  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'

  # spork, drb server
  gem 'spork', '>= 0.9.0.rc2'

  # capybara
  gem 'capybara'
  gem 'launchy'

  # guard is a dsl, alternate to watchr, which is an alternate to autotest :)
  # there is bonus growl feature
  gem 'guard-rspec'
  gem 'growl'

  # rr
  gem 'rr'

  # coverage
  gem 'simplecov', :platforms => :mri_19, :require => false
end
