describe Party::ConferencesHelper do
  describe 'conference_path' do
    it 'should be conferences/:name:edition' do
      conference_path(:name => 'deep', :edition => 2011).should == 'conferences/deep/2011'
    end
  end
end