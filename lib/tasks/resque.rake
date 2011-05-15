require 'resque/tasks'
task "resque:setup" => :environment do
  require 'jobs/invoice_job'
end
