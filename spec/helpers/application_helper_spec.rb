require 'spec_helper'

describe ApplicationHelper do
  describe 'markdown' do
    it 'should render text using Markdown' do
      markdown('# markdown').strip.should == '<h1>markdown</h1>'
    end
  end
end
