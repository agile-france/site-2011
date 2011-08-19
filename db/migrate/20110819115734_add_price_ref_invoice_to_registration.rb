class AddPriceRefInvoiceToRegistration < Mongoid::Migration
  def self.up
    Registration.all.each do |r|
      r[:price] = r.execution.price
      r[:ref] = r.execution.matchee.order.ref
      r[:invoice_id] = r.execution.invoice.id
      r.save
    end
  end

  def self.down
    Registration.all.each do |r|
      Registration.db.collection('registrations').update({'_id' => r.id},
        {'$unset' => {price: 1, ref: 1, invoice_id: 1}})
    end
  end
end