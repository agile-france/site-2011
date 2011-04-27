require 'jobs/invoice_job'

class InvoicerJob
  @queue = :invoice

  def self.perform(conference_id)
    conference = Conference.find(conference_id)

    executions_by_user = Execution.invoiceable_for(conference).group_by{|e| e.user}

    executions_by_user.each do |pair|
      next unless pair.first
      args = pair.flatten.map{|o| o.id.to_s}
      puts "processing #{args}"
      Resque.enqueue(InvoiceJob, *args)
    end
  end
end

