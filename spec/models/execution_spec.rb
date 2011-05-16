require 'spec_helper'

describe Execution do
  it {should be_referenced_in(:user)}
  it {should be_referenced_in(:product)}
  it {should be_referenced_in(:order)}
  it {should be_referenced_in(:matchee)}
  it {should be_referenced_in(:invoice)}
  it {should reference_many(:registrations)}

  it {should have_field(:side).with_default_value_of('B')}
  it {should validate_inclusion_of(:side).to_allow('B', 'A')}

  it {should have_field(:price).of_type(Float).with_default_value_of(0)}
  it {should validate_numericality_of(:price)}

  it {should have_field(:quantity).of_type(Integer).with_default_value_of(1)}
  it {should validate_numericality_of(:quantity)}

  describe "#amount" do
    it "is quantity * price" do
      Execution.new(:price => 3, :quantity => 4).amount.should == 12
    end
  end
  describe "#match_with" do
    it "set match association for self and matchee" do
      e, matchee = 2.times.map{Execution.new(:price => 3, :quantity => 4)}
      e.match_with(matchee)
      assert {e.matchee == matchee}
      assert {matchee.matchee == e}
    end
  end

  describe "registers" do
    let!(:john) {Fabricate.build(:user)}
    let!(:mark) {Fabricate.build(:user, :email => 'mark@mail.no')}
    let!(:place) {Fabricate.build(:product)}
    let!(:execution) {Fabricate.build(:execution, :user => john, :product => place, :quantity => 1)}
    it "registers a user for a product" do
      registration = execution.registers(john, place)
      assert {registration.product == place}
      assert {registration.user == john}
      assert {registration.execution == execution}
      assert {john.registered_to?(place)}
      assert {john.registrations.size == 1}
    end
    it "does not registers same user twice to same product" do
      2.times{execution.registers(john, place)}
      assert {john.registrations.size == 1}
    end
    it "accumulates registration in execution" do
      assert {execution.registrations.size == 0}
      registration = execution.registers(john, place)
      assert {execution.registrations == [registration]}
    end
    it "can not register more than quantity users" do
      [john, mark].each{|user| execution.registers(user, place)}
      deny {mark.registered_to?(place)}
    end
  end

  describe "build_registrations!" do
    let!(:john) {Fabricate.build(:user)}
    let!(:xp) {Fabricate.build(:conference)}
    let!(:place) {Fabricate.build(:product, :conference => xp)}
    let!(:execution) {Fabricate.build(:execution, :user => john, :product => place, :quantity => 10)}
    it "builds quantity registrations" do
      assert {execution.registrations.size == 0}
      registrations = execution.build_registrations!
      assert {registrations.size == 10}
      registrations.each do |r|
        assert {r.conference == xp}
        assert {r.product == place}
        assert {r.execution == execution}
        deny {r.user}
      end
    end
  end

  describe ".cancel! or .update!" do
    let(:john) {Fabricate.build(:user)}
    let(:mark) {Fabricate.build(:user, :email => 'mark@mail.no')}
    let(:place) {Fabricate.build(:product)}
    let(:matchee) {Fabricate.build(:execution, :user => john, :product => place, :quantity => 2, price: 10)}
    let(:execution) {Fabricate.build(:execution, :user => john, :product => place, :quantity => 2, matchee: matchee, price: 10)}
    before do
      execution.registers(john, place)
      execution.registers(mark, place)
    end
    it ".cancel! decrease execution quantity and destroys extra registrations, and same for matchee" do
      Execution.cancel!(execution, 1)
      assert {execution.quantity == 1}
      assert {execution.registrations.size == 1}
      assert {matchee.quantity == 1}
      assert {matchee.registrations.size == 0}
    end
    it ".update! updates execution price, execution and matchee" do
      Execution.update!(execution, 5)
      assert {execution.price == 5}
      assert {matchee.price == 5}
    end
  end
end