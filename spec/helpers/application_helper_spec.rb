require 'spec_helper'

describe ApplicationHelper do
  describe 'markdown' do
    it 'should render text using Markdown' do
      markdown('# markdown').strip.should == '<h1>markdown</h1>'
    end
  end
  
  describe "id_for_resource" do
    context "new resource" do
      it 'is a folded string with class name, _, id' do
        session = Session.new
        session.stubs(:id).returns(1)
        assert {id_for_resource(session) == "session_1"}
      end
    end
  end
end
