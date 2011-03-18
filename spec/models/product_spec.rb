require 'spec_helper'

describe Product do
  it {should have_field(:ref)}
  it {should validate_uniqueness_of(:ref)}
  it {should validate_presence_of(:ref)}
  
  describe "best_offer" do
    let!(:foo) {Product.new(:ref => 'foo')}
    before do
      # XXX introduce factory|fabricator|blueprint ?
      @orders = [5, 2, 3].map{|p| Order.new(:product => foo, :price => p, :side => Order::Side::ASK)}
      foo.stubs(:orders).returns(@orders)
    end
    
    it "returns the offer having lowest ASK price" do
      assert {foo.orders == @orders}
      assert {foo.best_offer.price == 2}
    end
  end
end

