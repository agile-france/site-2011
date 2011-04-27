require 'spec_helper'

describe Invoice do
  let(:xp) {Ducks.conference}
  let(:place) {xp.products.to_a.first}
  let(:diner) {xp.products.to_a.second}
  let(:invoice) {Invoice.new}

  context "with executions" do
    describe "#compute" do
      before do
        place.executions.build(invoice: invoice, :price => 200, :quantity => 5)
        place.executions.build(invoice: invoice, :price => 200, :quantity => 5)
        place.executions.build(invoice: invoice, :price => 300, :quantity => 5)
        diner.executions.build(invoice: invoice, :price => 50, :quantity => 10)
        invoice.compute
      end
      it "folds amount" do
        assert {invoice.amount == 4000}
      end
      it "folds lines" do
        lines = invoice.lines
        assert {lines[place] == {200.0 => 10, 300.0 => 5}}
        assert {lines[diner] == {50.0 => 10}}
      end
      it { deny{invoice.empty?} }
    end
  end

  context "without execution" do
    specify { assert{invoice.empty?} }
    specify { assert{invoice.compute.empty?} }
  end

  describe "#paid?" do
    let(:invoice) {Invoice.new}
    before do
      invoice.executions.build(:product => place, :price => 200, :quantity => 5)
    end
  end
end