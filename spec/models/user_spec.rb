require 'spec_helper'
describe User do
  describe 'full_name' do
    it 'should return John Doe for john' do
      Factory.create(:user, :first_name => 'John', :last_name =>'Doe').
              full_name.should == 'John Doe'
    end

    it 'should be nil if first name and last name are nil' do
      Factory.create(:user).full_name.should be_nil
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
