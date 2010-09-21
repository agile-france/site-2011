task :coverage do
  require 'simplecov'
  SimpleCov.start 'rails'

  task(:spec).invoke
  task(:cucumber).invoke
end