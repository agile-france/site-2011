class MigrateInvoices < Mongoid::Migration
  # gains conference from child execution documents
  def self.up
    Invoice.all.each do |invoice|
      invoice[:conference_id] = (invoice.executions.first ?
        invoice.executions.first.product.conference : Conference.first).id
      invoice.save
      say "invoice(#{invoice.id}) gains conference (#{invoice[:conference_id]})"
    end
  end

  def self.down
    Invoice.all.each do |invoice|
      Invoice.db.collection('invoices').update({'_id' => invoice.id}, {'$unset' => {conference_id: 1}})
    end
  end
end