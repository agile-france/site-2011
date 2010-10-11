require 'spec_helper'

describe "sessions/edit.html.haml" do
  before do
    @xp = Fabricate(:conference)
    @session = Fabricate(:session, :id => '123456789012345678901234', 
      :title => 'courage', :conference => @conference)

    assign(:session, @session)
    render
  end
  it 'should use PUT to /sessions/123456789012345678901234' do
    rendered.should have_tag('form[action="/sessions/123456789012345678901234"]')
    # PUT is POST+hidden field (see http://guides.rubyonrails.org/form_helpers.html#how-do-forms-with-put-or-delete-methods-work)
  end
end
