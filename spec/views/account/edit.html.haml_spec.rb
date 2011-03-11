require 'spec_helper'

describe "account/edit.html.haml" do
  let!(:user) {Fabricate.build(:user, :email => 'test@example.com')}
  before do
    assign(:user, user)
    render
  end
  
  it 'should have email input tag' do
    assert {doc(rendered).xpath('//input[@name="user[email]"][@value="test@example.com"]')}
  end
  it 'should have a sponsor checkbox for optouts' do
    rendered.should have_tag('//input[@name="optins[sponsors]"]')
  end
end
