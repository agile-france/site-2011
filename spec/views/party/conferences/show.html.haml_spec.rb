require 'spec_helper'

describe "party/conferences/show.html.haml" do
  it 'should have a link to propose a new session' do
    assign(:conference, Factory(:conference))
    render
    rendered.should have_tag('a', :content => t('party.propose_a_new_session?'))
  end
end
