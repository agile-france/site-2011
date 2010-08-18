require 'spec_helper'
describe User do
  describe 'greeter_name' do
    it 'should return John Doe' do
      Factory.create(:user, :first_name => 'John', :last_name =>'Doe').
              greeter_name.should == 'John Doe'
    end

    it 'should return Bob' do
      Factory.create(:user, :first_name => 'bob').greeter_name.should == 'Bob'
    end

    it 'should be john@doe.com if no names' do
      Factory.create(:user).greeter_name.should == 'john@doe.com'
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

  describe 'propose' do
    before do
      @john = Factory.create(:user)
    end

    it ', should add session to user' do
      @john.sessions.should = []  
    end
  end
end
