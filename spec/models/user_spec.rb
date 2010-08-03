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
    it ', first name should be capitalized on validation' do
      Factory.create(:user, :first_name => 'john').first_name.should == 'John'
    end
    it ', last name should be capitalized on validation' do
      Factory.create(:user, :last_name => 'doe').last_name.should == 'Doe'  
    end
  end
end
