require 'spec_helper'

describe Conference do
  it {should reference_many(:products)}
    
  it 'has a conpound id : #{name}-#{edition}' do
    assert {Conference.new(:name => 'xp', :edition => '2030').id == "xp-2030"}
  end
  
  describe "#owner" do
    let(:xp) {Fabricate.build(:conference)}
    let(:xp_dot_org) {Fabricate.build(:user, :email => 'conf@xp.org')}
    it "is a user, representing organization of conference" do
      assert {xp.owner == nil}
      xp.owner = xp_dot_org
      assert {xp.owner == xp_dot_org}
    end
  end
  
  # XXX with embeds -> embeds is a true PAIN IN THE ASS !!
  # using new_records and << just produce crap !
  # collection.build produce correct fixture
  # arrrghh.
  describe "best_offers" do
    let!(:xp) {Fabricate.build(:conference)}
    before do
      products = ['place', 'diner'].map {|p| Product.new(:name => p).tap {|p| stub(p).best_offer {p.name}}}
      stub(xp).products {products}
    end    
    it "returns the map of products with best_offer" do
      assert {xp.best_offers == ['place', 'diner']}
    end      
  end
  
  describe "emit!" do
    let(:product) {Fabricate.build(:product)}
    let(:john) {Fabricate.build(:user)}    
    let(:xp) {Fabricate.build(:conference)}
    context "conference has an owner" do
      before do
        xp.owner = john
      end
      it "creates an ASK order for its owner" do
        order = xp.emit!('YOOZOO', 10, product, 220)
        assert {order.side == Order::Side::ASK}
        assert {order.product == product}
        assert {order.quantity == 10}
        assert {order.price == 220}
        assert {order.ref == 'YOOZOO'}
        assert {order.persisted?}
      end
    end
    context "no user" do
      it "raise a StandardError" do
        expect {xp.emit!(nil, 10, product, 220)}.to raise_error {|error|
          error.should be_a RuntimeError
        }
      end
    end
  end
end