require 'spec_helper'

describe "account/edit.html.haml" do
  before do
    @user = Fabricate(:user, :email => 'test@example.com')
    assign(:user, @user)
    render
  end
  
  it 'should have email input tag' do
    assert {doc(rendered).xpath('//input[@name="user[email]"][@value="test@example.com"]')}
  end
  it 'should have a sponsor checkbox for optouts' do
    rendered.should have_tag('//input[@name="optins[sponsors]"]')
  end
end
