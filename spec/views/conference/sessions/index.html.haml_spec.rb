require 'spec_helper'

describe 'conference/sessions/index.html.haml' do
  before do
    @titles = ['courage', 'respect']
    assign(:sessions, @titles.map {|title| Factory(:session, :title => title)})
  end
  
  it 'should show list of proposed sessions' do
    render
    @titles.each do |title|
      rendered.should have_tag('td', :content => title)
    end
  end
end