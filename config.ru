# This file is used by Rack-based servers to start the application.
# use Rack::Static, :root => 'tmp', :urls => ['/stylesheets']

# rails usual
require ::File.expand_path('../config/environment',  __FILE__)
run ConferenceOnRails::Application
