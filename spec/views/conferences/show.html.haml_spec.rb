require 'spec_helper'

describe "conferences/show.html.haml" do
  before do
    @xp = Factory(:conference, :id => 3)
    @kent = Factory(:user, :first_name => 'kent', :last_name => 'beck')
    @kent.propose(Session.new({:id => 6, :title => 'explained'}), @xp)
    assign(:conference, @xp)
    render
  end

  it 'should have a link to propose a new session' do
    rendered.should have_tag('a[href="/conferences/3/sessions/new"]',
                             t('party.session.new?'))
  end

  it 'should have a nice title' do
    rendered.should have_tag('h1')
  end
  
  it 'should have a link to session' do
    rendered.should have_tag('a[href="/sessions/6"]') 
  end
end
