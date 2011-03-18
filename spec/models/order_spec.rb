require 'spec_helper'

describe Order do
  it {should be_referenced_in(:user)}
  it {should be_referenced_in(:product)}
  it {should reference_many(:executions)}
  
  it {should have_field(:side).with_default_value_of('B')}
  it {should validate_inclusion_of(:side).to_allow('B', 'A')}

  it {should have_field(:price).of_type(Float).with_default_value_of(0)}
  it {should validate_numericality_of(:price)}

  it {should have_field(:quantity).of_type(Integer).with_default_value_of(1)}
  it {should validate_numericality_of(:quantity)}
  
  it {should have_field(:ref)}
  # XXX validates length of ref in 0..20
  
  describe "executed|remaining quantities" do
    let(:o) {Order.new(:quantity => 100)}
    context "no execution" do
      it "is the quantity" do
        assert {o.remaining == 100}
        assert {o.executed == 0}
      end      
    end
    context "with executions" do
      before do
        2.times {o.executions.build(:quantity => 1)}
      end
      it "is the quantity minus sum of executed quantity" do
        assert {o.executed == 2}
        assert {o.remaining == 98}
      end
    end
  end
  
  describe ".opposite" do
    it "returns a BID order for an ASK order" do
      opposite = Order.opposite(Order.new(:side => Order::Side::BID))
      assert {opposite.side == Order::Side::ASK}
    end
  end
  
  describe "matches?" do
    let!(:bid) {Fabricate.build(:bid, :price => 10)}
    let!(:match) {Fabricate.build(:ask, :price => 10)}
    let!(:nomatch) {Fabricate.build(:ask, :price => 100)}
    it {deny {bid.matches?(bid)}}
    it {deny {bid.matches?(nomatch)}}
    it {deny {nomatch.matches?(bid)}}
    it {assert {match.matches?(bid)}}
    it {assert {bid.matches?(match)}}
  end
  
  describe "fill!" do
    let(:bid) {Fabricate.build(:bid, :price => 300, :quantity => 10)}    
    it "builds an execution for this order, at given price and quantity" do
      bid.fill!(3, 200)
      e = bid.executions.first
      assert {e.quantity == 3}
      assert {e.price == 200}
    end
    it "flags order as partially filled" do
      deny {bid.partially_filled?}
      bid.fill!(3, 200)
      assert {bid.partially_filled?}
    end
    it "can be called many times up to completely filled" do
      bid.fill!(3, 200)
      bid.fill!(bid.quantity, 200)
      assert {bid.filled?}
    end
  end
end