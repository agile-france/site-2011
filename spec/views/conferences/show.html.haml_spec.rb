require 'spec_helper'

describe "conferences/show.html.haml" do
  before do
    @xp = Fabricate(:conference)
    @kent = Fabricate(:user, :first_name => 'kent', :last_name => 'beck')
    @explained = Fabricate(:session, :id => id(6), :title => 'explained')
    @kent.propose(@explained, @xp)
    assign(:conference, @xp)
    render
  end

  it 'should have a link to propose a new session' do
    rendered.should have_tag("a[href=\"/conferences/#{@xp.id}/sessions/new\"]",
                             t('party.session.new?'))
  end

  it 'should have a nice title' do
    rendered.should have_tag('h1')
  end
  
  it 'should have a link to session' do
    assert {@xp.sessions == [@explained]}
    rendered.should have_tag("a[href=\"/sessions/#{id(6)}\"]") 
  end
end
