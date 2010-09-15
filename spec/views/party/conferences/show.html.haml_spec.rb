require 'spec_helper'

describe "party/conferences/show.html.haml" do
  before do
    @conference = Factory(:conference)
    assign(:conference, @conference)
    render
  end

  it 'should have a link to propose a new session' do
    rendered.should have_tag('a', :href => new_conference_session_path(@conference),
                             :content => t('party.propose_a_new_session?'))
  end

  it 'should have a nice title' do
    rendered.should have_tag('h1')
  end
end
