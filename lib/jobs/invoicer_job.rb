class InvoicerJob
  @queue = :invoice

  def self.perform
    conference = Conference.first

    executions_by_user = Execution.invoiceable_for(conference).group_by{|e| e.user}

    executions_by_user.each do |pair|
      next unless pair.first
      args = pair.flatten.map{|o| o.id.to_s}
      puts "processing InvoiceJob #{args}"
      Resque.enqueue(InvoiceJob, *args)
    end
    nil
  end
end

