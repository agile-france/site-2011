require 'rubygems'
if ENV['COVERAGE'] and RUBY_VERSION =~ /1\.9/
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'spork'
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  
  # https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu
  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)
  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)
  
  # rest is rather normal
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    config.extend ScopedDatabaseAccess
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :mocha
    
    ## see http://mongoid.org/docs/integration
    ## and http://github.com/bmabey/database_cleaner
    require 'database_cleaner'
    DatabaseCleaner.strategy = :truncation
    config.before(:suite) do
      DatabaseCleaner.clean
    end
  end  
end

Spork.each_run do
end