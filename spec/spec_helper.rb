if ENV['COVERAGE'] and RUBY_VERSION =~ /1\.9/
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rr'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


  Rspec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rr
    
    ## see http://mongoid.org/docs/integration
    ## and http://github.com/bmabey/database_cleaner
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.orm = 'mongoid'
      DatabaseCleaner.strategy = :truncation    
    end
    config.before(:each) do
      DatabaseCleaner.clean
    end
  end  
end

Spork.each_run do
  ### issues are
  # http://github.com/rspec/rspec-core/issues/62
  # http://github.com/thoughtbot/factory_girl/issues/55
  # 
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }   
end

# --- Instructions ---
# - Sort through your spec_helper file. Place as much environment loading 
#   code that you don't normally modify during development in the 
#   Spork.prefork block.
# - Place the rest under Spork.each_run block
# - Any code that is left outside of the blocks will be ran during preforking
#   and during each_run!
# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.