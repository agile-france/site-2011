require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the Party::ConferencesHelper. For example:
#
# describe Party::ConferencesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ConferencesHelper do
  describe '#introduce' do
    it 'should slashify name and edition' do
      deep = Factory(:conference, :name => 'deep', :edition => 2011)
      helper.introduce(deep).should == 'deep/2011'
    end
  end
end
