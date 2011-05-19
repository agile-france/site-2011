namespace :jobs do
  desc "clean orphans"
  task :clean_orphans => :environment do
    OrphanCleanerJob.perform
  end

  desc "auto assign single unassigned registration"
  task :assign_self => :environment do
    SelfAssignerJob.perform
  end

  desc "invoice to the rescue"
  task :invoice => :environment do
    InvoicerJob.perform
  end

  desc "emails to the rescue"
  task :email_invoices => :environment do
    InvoicerMailerJob.perform
  end
end
