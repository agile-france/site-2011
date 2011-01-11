require 'spec_helper'
describe User do
  describe '#greeter_name' do
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
  
  describe '#bio' do
    before do
      @john = Fabricate(:user)
    end    
    it 'can have one bio' do
      assert {@john.bio.nil?}
      @john.update_attributes!(:bio => 'defunkt')
      assert {@john.bio == 'defunkt'}
      @john.update_attributes!('bio' => 'flunk')
      assert {@john.bio == 'flunk'}
    end
  end
  
  # admin
  describe '#admin' do
    it {should have_fields(:admin).of_type(Boolean).with_default_value_of(false)}
    it 'should have an handy #admin?' do
      john = Fabricate(:user)
      deny {john.admin?}
    end
    it 'should make an admin' do
      john = Fabricate(:user, :admin => true)
      assert {john.admin?}
    end
  end
  
  describe "#avatar" do
    context "twitter authentication" do
      before do
        (@user = Fabricate(:user)).authentications.create!({:active => true}.merge(Authentications::Twitter.data))
        # guard
        authentication = @user.authentications.first
        @avatar_uri = authentication.user_info['image']
        assert {@avatar_uri =~ %r{^http://a2.twimg.com/profile_images}}
      end
      it "is image from twitter" do
        assert {@user.avatar == [:twitter, @avatar_uri]}
      end
    end
    context "github authentication" do
      before do
        (@user = Fabricate(:user)).authentications.create!({:active => true}.merge(Authentications::Github.data))
      end
      it "is image from gravatar" do
        assert {@user.avatar == [:gravatar, 'http://www.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee']}
      end
    end
  end
end
