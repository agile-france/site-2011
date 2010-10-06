require 'spec_helper'

describe "conferences/index.html.haml" do
  before do
    @conferences = (2010..2012).map {|edition| Fabricate(:conference, :name => 'deep', :edition => edition)}
    assign(:conferences, @conferences)
    render
  end

  it 'should contain a link for each conference' do
    @conferences.each do |conference|
      rendered.should have_tag('td a',
                               :href => conference_path(conference), :content => "#{conference.name}/#{conference.edition}")
    end
  end
end
