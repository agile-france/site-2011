require "spec_helper"

describe Mailer do
  describe "invoice is available" do
    let(:bill) {Fabricate.build :user, first_name: 'Bill', last_name: 'Doe', email: 'bill@doe.com'}
    let(:invoice) {Fabricate.build :invoice, ref: 'INV-0001', user: bill}
    let(:email) {Mailer.invoice_ready(invoice)}
    it "comes from conference owner" do
      email.from.should == ['orga@conf.agile-france.org']
    end
    it "is to invoice payer" do
      email.to.should == ['bill@doe.com']
    end
  end
end
