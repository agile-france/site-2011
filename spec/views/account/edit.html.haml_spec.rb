require 'spec_helper'

describe "account/edit.html.haml" do
  before do
    @user = Fabricate(:user, :email => 'test@example.com')
    assign(:user, @user)
    render
  end
  
  it 'should have email form tag' do
    assert {doc(rendered).xpath('//@name="user[email]"')}
  end
end
