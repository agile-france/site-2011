require 'spec_helper'

class Collection < Array
  def where(expression)
    condition = expression.values.first
    case condition
    when Regexp
      self.select {|v| v =~ condition}
    else
      self.select {|v| v == condition}
    end
  end
end

describe Controllers::Search::Criteria do
  let(:controller) {Object.new.extend Controllers::Search::Criteria}
  let(:collection) {Collection.new}
  before do
    collection.concat(['Wine', 'In'])
  end
  describe "search a string" do
    it 'yields same results as /string/i' do
      assert {controller.search(collection, :word => 'in') == ['Wine', 'In']}
    end
  end
  describe "search a regexp" do
    it 'yield matching terms' do
      assert {controller.search(collection, :word => '/in/') == ['Wine']}
    end
  end
end