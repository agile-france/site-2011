# -*- encoding: utf-8 -*-
class InvoiceJob
  @queue = :invoice

  class << self
    def perform(user_id, *execution_ids)
      puts "processing user=#{user_id}, executions=#{execution_ids}"
      user = User.find(user_id)
      executions = execution_ids.map{|execution_id| Execution.find(execution_id)}
      invoice = Invoice.new(user: user, executions: executions)
      # doh!
      puts "invoicing #{user.greeter_name} : #{invoice.amount}"
      # post and get back xero InvoiceNumber
      node = client.put! :invoices, body: to_xml(invoice)
      invoice.ref = node.xpath('/Response/Invoices/Invoice/InvoiceNumber').first.content
      # save
      invoice.save!
      puts "processing PdfJob #{invoice.id.to_s}"
      Resque.enqueue(PdfJob, invoice.id.to_s)
    end

    private
    def erb
      @erb ||= XeroMin::Erb.new(File.expand_path('../xero/templates', __FILE__))
    end
    def client
      Xero.client
    end
    def to_xml(invoice)
      erb.render(invoice: invoice)
    end
  end
end