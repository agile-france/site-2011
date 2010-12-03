# Load the rails application
require File.expand_path('../application', __FILE__)

# define here what heroku config store in account
# see http://tammersaleh.com/posts/managing-heroku-environment-variables-for-local-development
# deploy with git, though keep private informations ...
heroku = File.expand_path("environments/heroku/#{Rails.env}.rb", File.dirname(__FILE__))
load heroku if File.exists?(heroku)

# Initialize the rails application
ConferenceOnRails::Application.initialize!
