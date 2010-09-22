require 'spec_helper'

describe "sessions/edit.html.haml" do
  before do
    @xp = Factory(:conference)
    @session = Factory(:session, :id => 123, :title => 'courage', :conference => @conference)

    assign(:session, @session)
    render
  end
  it 'should use PUT to /sessions/123' do
    rendered.should have_tag('form[action="/sessions/123"]')
    # PUT is POST+hidden field (see http://guides.rubyonrails.org/form_helpers.html#how-do-forms-with-put-or-delete-methods-work)
  end
end
