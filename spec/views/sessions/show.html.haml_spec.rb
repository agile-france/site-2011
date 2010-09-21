require 'spec_helper'

describe 'sessions/show.html.haml' do
  before do
    @kent = Factory(:user, :email => "kent@beck.org")
    @ron = Factory(:user, :email => "ron@jeffries.org")
    @xp = Factory(:conference, :name => 'xp', :id => 2)
    @explained = Factory(:session, :title => 'explained', :conference => @xp, :user => @kent, :id => 4)
  end

  describe ', with author logged in' do
    before do
      stub(controller).current_user {@kent}      
      assign(:session, @explained)
    end
    
    it 'should have an update link' do
      render
      rendered.should have_tag('a[href="/conferences/2/sessions/4/edit"]')
    end
  end
  
  describe ', with reader logged in' do
    before do
      stub(controller).current_user {@ron}      
      assign(:session, @explained)
    end
    
    it 'should have an update link' do
      render
      rendered.should_not have_tag('a[href="/conferences/2/sessions/4/edit"]')
    end
  end
end


