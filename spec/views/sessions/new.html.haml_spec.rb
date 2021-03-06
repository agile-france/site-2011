require 'spec_helper'

describe "sessions/new.html.haml" do
  before do
    assign(:conference, Fabricate(:conference))
    assign(:session, Fabricate(:session))
    render
  end
  it 'should have a title text field' do
    rendered.should have_tag('label', :content => 'Titre')
  end
  it 'should have a description text field' do
    rendered.should have_tag('label', :content => 'Description')
  end
end
