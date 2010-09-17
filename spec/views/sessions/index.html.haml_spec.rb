require 'spec_helper'

describe 'party/sessions/index.html.haml' do
  before do
    @conference = Factory(:conference)
    @sessions = ['courage', 'respect'].map { |title|
      Factory(:session, :title => title, :conference => @conference)
    }
  end

  it 'should show list of proposed sessions' do
    # XXX view spec is not able to render modularized controller
    render :template => 'sessions/index.html.haml', :locals => {:sessions => @sessions}
    @sessions.each do |session|
      # XXX a link is not enough there, I want the uri to where it goes
      rendered.should have_tag('td a', session.title)
    end
  end
end