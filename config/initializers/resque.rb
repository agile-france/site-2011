require 'resque/server'
require 'resque'
Dir.glob("#{Rails.root}/lib/jobs/*.rb").each {|f| load f}