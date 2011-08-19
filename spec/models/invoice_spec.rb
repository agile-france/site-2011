require 'spec_helper'

describe Invoice do
  let(:xp) {Ducks.conference}
  let(:place) {xp.products.to_a.first}
  let(:diner) {xp.products.to_a.second}
  let(:invoice) {Invoice.new}

  describe "#amount and #lines" do
    before do
      place.registrations.build(invoice: invoice, :price => 200, :ref => "E")
      place.registrations.build(invoice: invoice, :price => 300, :ref => "S")
      place.registrations.build(invoice: invoice, :price => 300, :ref => "S")
      diner.registrations.build(invoice: invoice, :price => 50, :ref => "D")
    end
    it "folds amount" do
      assert {invoice.amount == 850}
    end
    it "folds lines" do
      lines = invoice.lines
      assert {lines[place] == {200.0 => 1, 300.0 => 2}}
      assert {lines[diner] == {50.0 => 1}}
    end
  end

  describe "#invoiceable?" do
    it "invoice with 0 amount is not invoiceable" do
      deny {invoice.invoiceable?}
    end
    it "is true when amount to invoice is > 0" do
      place.registrations.build(invoice: invoice, :price => 200)
      invoice.should be_invoiceable
    end
  end

  describe "#paid?" do
    let(:invoice) {Invoice.new}
    before do
      invoice.executions.build(:product => place, :price => 200, :quantity => 5)
    end
  end
end