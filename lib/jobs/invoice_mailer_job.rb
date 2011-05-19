class InvoiceMailerJob
  @queue = :mail

  def self.perform(id)
    invoice = Invoice.find(id)
    puts "sending #{invoice.ref} to #{invoice.user.email}"
    Mailer.invoice_ready(invoice).deliver
  end
end