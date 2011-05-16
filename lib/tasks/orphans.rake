namespace :jobs do
  desc "clean orphans"
  task :orphans => :environment do
    OrphansJob.perform
  end
end
