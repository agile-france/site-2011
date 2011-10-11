source 'http://rubygems.org'

gem 'rails', '~> 3.1'

# js
gem 'jquery-rails'

# pagination
gem 'kaminari'

# views
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'

# authentication
gem 'devise'
gem 'oa-oauth'
gem 'oa-openid'

# markdown
gem 'rdiscount'

# mongo
gem 'mongoid'
gem 'mongoid_taggable'
gem 'mongoid_rails_migrations'
gem 'mongo'
gem 'bson_ext'

# authorization
gem 'cancan'

# json
gem 'yajl-ruby', require: 'yajl'

# xero
gem 'xero-min', '>= 0.0.7'

# uploader
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'

# jobs
gem 'resque'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :development, :test do
  gem 'rails-footnotes', '>= 3.7.5'
  gem 'rspec-rails'

  # factory (required for scaffold)
  gem 'fabrication'

  gem 'ruby-debug19', platforms: :mri_19

  # js
  gem 'jasmine'
end

group :test do
  gem 'rspec_tag_matchers'
  gem 'mongoid-rspec'
  gem 'wrong'

  # cucumber
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
  gem 'simplecov', platforms: :mri_19, require: false
end
