require File.expand_path('../boot', __FILE__)
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'

# FIXME this is ugly
if ENV['MONGOHQ_URL']
  require 'uri'
  uri = URI.parse(ENV['MONGOHQ_URL'])
  ENV['MONGOID_HOST'] = uri.host
  ENV['MONGOID_PORT'] = uri.port.to_s
  ENV['MONGOID_USERNAME'] = uri.user
  ENV['MONGOID_PASSWORD'] = uri.password
  ENV['MONGOID_DATABASE'] = uri.path[1..-1]
end

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module ConferenceOnRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{config.root}/extras )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :fr and fallbacks to :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = {:fr => :en}

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm :mongoid
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true
      g.fixture_replacement :fabrication, :dir => "spec/fabricators"      
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
