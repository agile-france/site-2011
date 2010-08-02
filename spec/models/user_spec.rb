require 'spec_helper'
describe User do
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}

  describe 'full_name' do
    it 'should return John Doe' do
      Factory.create(:user).full_name.should == 'John Doe'
    end
  end
end
