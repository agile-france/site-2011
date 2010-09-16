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
    render :template => 'party/sessions/index.html.haml', :locals => {:sessions => @sessions}
    @sessions.each do |session|
      rendered.should have_tag('td a', :content => session.title)
    end
  end
end