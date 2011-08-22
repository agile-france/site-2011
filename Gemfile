source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

gem 'rails', '>= 3.0.0'
gem 'jquery-rails'

# views
gem 'haml'
gem 'sass'
gem 'haml-rails'
gem 'will_paginate', '>= 3.0.pre2'

# authentication
gem 'devise'
gem 'oa-oauth'
gem 'oa-openid'

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid'
gem 'mongoid_taggable'
gem 'mongoid_rails_migrations'
gem 'mongo'
gem 'bson_ext'

# cant
gem 'cant'

# json
gem 'yajl-ruby', :require => 'yajl'

# rbtree
gem 'rbtree'

# xero
gem 'xero-min', '>= 0.0.7'

# uploader
gem 'carrierwave'

# jobs
gem 'resque'

group :development, :test, :cucumber do
  gem 'thin'
  gem "rspec-rails"

  # factory (required for scaffold)
  gem 'fabrication'

  gem 'ruby-debug19', :platforms => :mri_19

  # js
  gem 'barista'
  gem 'therubyracer', :require => false
  gem 'jasmine'
end

group :test, :cucumber do
  gem "rspec_tag_matchers"
  gem 'mongoid-rspec'
  gem 'wrong'

  # cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'database_cleaner'

  # spork, drb server
  gem 'spork', '>= 0.9.0.rc9'

  # capybara
  gem 'capybara'
  gem 'launchy'

  # guard is a dsl, alternate to watchr, which is an alternate to autotest :)
  # there is bonus growl feature
  gem 'guard-rspec'
  gem 'guard-coffeescript'
  gem 'growl'

  # double
  gem 'mocha'

  # coverage
  gem 'simplecov', :platforms => :mri_19, :require => false
end
