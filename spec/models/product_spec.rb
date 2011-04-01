require 'spec_helper'

describe Product do
  it {should have_field(:ref)}
  it {should validate_uniqueness_of(:ref)}
  it {should validate_presence_of(:ref)}

  describe "offers" do
    let(:foo) {Product.new(:ref => 'foo')}
    before do
      @orders = [5, 2, 3].map{|p| Fabricate.build(:ask, :product => foo, :price => p)}
      foo.stubs(:orders).returns(@orders)
    end
    it "returns Book.lines for asks" do
      assert {foo.offers == [[10, 2], [10, 3], [10, 5]]}
    end
  end
end

