class InvoicerMailerJob
  @queue = :invoice

  def self.perform
    Invoice.all.each do |invoice|
      Resque.enqueue(InvoiceJob, invoice.id.to_s)
    end
  end
end