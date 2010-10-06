require 'spec_helper'
describe User do
  describe 'greeter_name' do
    it 'should be first and last name' do
      Fabricate(:user, :first_name => 'John', :last_name =>'Doe').
              greeter_name.should == 'John Doe'
    end

    it 'should be first name when last is missing' do
      Fabricate(:user, :first_name => 'bob').greeter_name.should == 'Bob'
    end

    it 'should be email if no names' do
      Fabricate(:user).greeter_name.should == 'john@doe.com'
      end

    it 'should be email if blank names' do
      # this is actually what is submitted through POST form
      Fabricate(:user, :first_name => '').greeter_name.should == 'john@doe.com'
    end
  end

  describe 'names' do
    it 'first name is capitalized on validation' do
      Fabricate(:user, :first_name => 'john').first_name.should == 'John'
    end
    it 'last name is capitalized on validation' do
      Fabricate(:user, :last_name => 'doe').last_name.should == 'Doe'  
    end
  end

  describe 'can propose a session to a conference' do
    before do
      @john = Fabricate(:user)
      @cheesy = Fabricate(:conference, :name => 'cheesy')
      @cheddar = Fabricate(:session, :title => 'cheddar')

      @john.propose(@cheddar, @cheesy).should == @john
    end

    it 'then session and user are wired' do
      assert {@cheddar.user == @john}
      assert {@john.sessions.include? @cheddar}
    end

    it 'then session and conference are wired' do
      @cheesy.sessions.should include(@cheddar)
    end
  end
end
