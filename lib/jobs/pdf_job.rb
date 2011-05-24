class PdfJob
  @queue = :pdf

  def self.perform(invoice_id)
    invoice = Invoice.find(invoice_id)
    # get invoice as pdf
    pdf = Xero.client.get!({invoice: invoice.ref}, accept: 'application/pdf')
    puts "successfully get pdf for #{invoice.ref}"
    io = StringIO.new(pdf)
    # OH !!
    (class << io; self; end).module_eval "def original_filename; '#{invoice.ref}.pdf'; end"
    invoice.pdf = io
    invoice.save!
    InvoiceMailerJob.perform(invoice.id.to_s)
  end
end