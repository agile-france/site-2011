require 'spec_helper'

describe "party/conferences/show.html.haml" do
  it 'should have a link to propose a new session' do
    conference = Factory(:conference)
    assign(:conference, conference)
    render
    rendered.should have_tag('a', :href => new_conference_session_path(conference),
                             :content => t('party.propose_a_new_session?'))
  end
end
