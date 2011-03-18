require 'spec_helper'

describe Book do
  let!(:bids) {[2, 1, 3].map{|p| Fabricate.build(:bid, :price => p)}}
  let!(:asks) {[20, 10, 30].map{|p| Fabricate.build(:ask, :price => p)}}
    
  describe "book" do    
    it "sorts asks on price ASC" do
      book = Book.new(asks)
      assert {book.bids.keys == []}
      assert {book.asks.keys == [10, 20, 30]}
    end
    it "sorts bids on price DESC" do
      book = Book.new(bids)
      assert {book.bids.keys == [3, 2, 1]}
      assert {book.asks.keys == []}
    end
    it "sorts bids and asks" do
      book = Book.new([*bids, *asks].shuffle)
      assert {book.bids.keys == [3, 2, 1]}
      assert {book.asks.keys == [10, 20, 30]}
    end
  end
  
  describe "accept" do
    context "with an asks book" do
      let!(:book) {Book.new(asks)}
      context "low bid" do
        let(:low) {Fabricate.build(:bid, :price => 9)}
        it "parks a low bid order" do
          list = book.accept(low)
          assert {list == [low]}
          assert {book.bids[low.price] == [low]}
        end        
      end
      context "high bid" do
        let(:high) {Fabricate.build(:bid, :price => 100, :quantity => 10)}
        before do
          @old_best_ask = book.best(book.asks)
          book.accept(high)
        end
        it "fills high" do
          assert {high.filled?}
          assert {high.executions.size == 1}
        end
        it "match executions" do
          assert {high.executions.first.matchee == @old_best_ask.executions.first}
        end
        it "does not park a matching bid order" do
          assert {book.bids[high.price].nil?}
        end
        it "matching ask is also filled" do
          assert {@old_best_ask.filled?}
          assert {@old_best_ask.executions.size == 1}
        end
        it "matching ask is removed from book" do
          assert {book.best(book.asks).price == 20}
        end
      end
      context "aggressive bid" do
        let(:aggressive) {Fabricate.build(:bid, :price => 100, :quantity => 15)}
        before do
          @asks = book.asks.values.flatten
          @list = book.accept(aggressive)
        end
        it "return list of updated or new transactions (order and execution)" do
          [aggressive, @asks[0], @asks[1]].each do |t|
              assert {@list.include? t}
          end
          [aggressive.executions.to_a, @asks[0].executions.first, @asks[1].executions.first].flatten.each do |t|
              assert {@list.include? t}
          end
        end
        it "is filled with 2 executions" do
          assert {aggressive.filled?}
          assert {aggressive.executions.size == 2}
          assert {aggressive.executions.first.price == 10}
          assert {aggressive.executions.second.price == 20}
        end
        it "matching ask is removed from book" do
          best = book.best(book.asks)
          assert {best.partially_filled?}
        end
      end
    end
  end
  
  describe ".[]" do
    let(:product) {Fabricate.build(:product)}
    before do
      orders = [*bids, *asks].shuffle
      product.stubs(:orders).returns(orders)
    end
    it "returns same book instance for same product (id)" do
      Book[product].should be_a Book
      Book[product].should equal Book[product]
    end
    it "initialize book with product orders" do
      Book[product].bids.keys.should == [3,2,1]
      Book[product].asks.keys.should == [10,20,30]
    end
  end
end