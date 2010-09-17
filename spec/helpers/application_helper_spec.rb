describe ApplicationHelper do
  describe 'markup' do
    it 'should render text using Markdown' do
      markup('# markdown').should == '<h1>markdown</h1>'
    end
  end
end