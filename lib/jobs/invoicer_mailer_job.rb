class InvoicerMailerJob
  @queue = :invoice

  def self.perform
    Invoice.all.each do |invoice|
      puts "processing InvoiceMailerJob #{invoice.id.to_s}"
      Resque.enqueue(InvoiceMailerJob, invoice.id.to_s)
    end
  end
end