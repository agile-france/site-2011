require 'spec_helper'
describe User do
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}

  describe 'full_name' do
    it 'should return John Doe' do
      Factory.create(:user, :first_name => 'John', :last_name =>'Doe').
              full_name.should == 'John Doe'
    end
  end

  describe 'names' do
    it 'should be capitalized on validation' do
      john = Factory.create(:user, :first_name => 'john')
      john.first_name.should == 'John'  
    end
  end
end
