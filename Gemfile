source 'http://rubygems.org'
def mac?
  RUBY_PLATFORM =~ /darwin/
end

gem 'rails', '>= 3.0.0'
gem 'jquery-rails'

# views
gem 'haml'
gem 'haml-rails'
gem 'will_paginate', '>= 3.0.pre2'

# authentication
gem 'devise', '>= 1.2.rc'
gem 'oa-oauth', '>= 0.2.0.beta1', :require => "omniauth/oauth"
gem 'oa-openid', '>= 0.2.0.beta1', :require => "omniauth/openid"

# rdiscount
gem 'rdiscount'

# mongo
gem 'mongoid', '>= 2.0.0.beta.19'
gem 'mongoid_taggable', '~> 0.1'
gem 'mongoid_rails_migrations'
gem 'mongo', '~> 1.3'
gem 'bson_ext', '~> 1.3'

# cant
gem 'cant'

# json
gem 'yajl-ruby', :require => 'yajl'

# rbtree
gem 'rbtree'

# xero
gem 'xero-min', path: '~/src/ruby/xero-min'

# jobs
gem 'resque'

group :development, :test, :cucumber do
  gem 'thin'
  gem "rspec-rails", ">= 2.1.0"

  # factory (required for scaffold)
  gem 'fabrication'

  gem 'ruby-debug19', :platforms => :mri_19

  # js
  gem 'barista', '~> 1.0'
  gem 'therubyracer', :require => false
end

group :test, :cucumber do
  gem "rspec_tag_matchers"
  gem 'mongoid-rspec'
  gem 'wrong', '~> 0.4'
  gem 'jasmine'

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
  gem 'guard-coffeescript'
  gem 'growl'

  # double
  gem 'mocha'

  # coverage
  gem 'simplecov', :platforms => :mri_19, :require => false
end
