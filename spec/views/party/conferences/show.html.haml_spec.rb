require 'spec_helper'

describe "party/conferences/show.html.haml" do
  before do
    @conference = Factory(:conference)
    assign(:conference, @conference)
    render
  end

  it 'should have a link to propose a new session' do
    rendered.should have_tag('a[href="/conferences/1/sessions/new"]',
                             t('party.session.new?'))
  end

  it 'should have a nice title' do
    rendered.should have_tag('h1')
  end
end
