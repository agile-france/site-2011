require 'spec_helper'

describe User do    
  describe '#greeter_name' do
    it 'should be first and last name' do
      User.new(:first_name => 'John', :last_name =>'Doe').greeter_name.should == 'John Doe'
    end

    it 'should be first name when last is missing' do
      User.new(:first_name => 'bob').greeter_name.should == 'bob'
    end

    it 'should be email if no names' do
      User.new(:email => 'john@doe.com').greeter_name.should == 'john@doe.com'
      end

    it 'should be email if blank names' do
      # this is actually what is submitted through POST form
      User.new(:first_name => '', :email => 'john@doe.com').greeter_name.should == 'john@doe.com'
    end
  end

  describe 'names' do
    # XXX DATABASE ACCESS
    before(:all) {@john = Fabricate(:user, :first_name => 'john', :last_name => 'doe')}
    after(:all) {@john.destroy}
    
    it 'first name is capitalized on validation' do
      @john.first_name.should == 'John'
    end
    it 'last name is capitalized on validation' do
      @john.last_name.should == 'Doe'  
    end
  end

  describe 'can propose a session to a conference' do
    # XXX DATABASE ACCESS
    touch_db_with(:john) {Fabricate(:user)}
    touch_db_with(:cheesy) {Fabricate(:conference, :name => 'cheesy')}
    touch_db_with(:cheddar) {Fabricate.build(:session, :title => 'cheddar')}
    before(:all) do
      john.propose(cheddar, @cheesy)
    end

    it 'then session and user are wired' do
      assert {cheddar.user == john}
      assert {john.sessions.include? cheddar}
    end

    it 'then session and conference are wired' do
      cheesy.sessions.should include(cheddar)
    end
  end
  
  # admin
  it {should have_fields(:admin).of_type(Boolean).with_default_value_of(false)}
  describe '#admin?' do
    it 'should have an handy #admin?' do
      john = Fabricate.build(:user)
      deny {john.admin?}
    end
  end
  
  describe "#avatar" do
    context "twitter authentication" do
      touch_db_with(:user) do 
        Fabricate(:user).tap{|u| u.authentications.create!({:active => true}.merge(Authentications::Twitter.data))}
      end
      before do
        # guard
        @avatar_uri = user.authentications.first.user_info['image']
        assert {@avatar_uri =~ %r{^http://a2.twimg.com/profile_images}}
      end
      it "is image from twitter" do
        assert {user.avatar == [:twitter, @avatar_uri]}
      end
    end
    context "github authentication" do
      touch_db_with(:user) do 
        Fabricate(:user).tap{|u| u.authentications.create!({:active => true}.merge(Authentications::Github.data))}
      end
      it "is image from gravatar" do
        assert {@user.avatar == [:gravatar, 'http://www.gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee']}
      end
    end
  end
  
  describe "#destroy" do
    let(:user) {Fabricate(:user)}
    before do
      @a = user.authentications.create
      @s = user.sessions.create
      user.destroy
    end
    it "destroys child authentications and sessions" do
      deny {Authentication.criteria.id(@a.id).first}
      deny {Session.criteria.id(@s.id).first}
    end
  end

  describe "optins feature" do
    it {should have_field(:optins).of_type(Array)}
    let(:joe) {User.new}
    describe "opting in" do
      it 'is true when opted in' do
        assert {joe.optin!(:twitter).optin?(:twitter)}
      end
      it 'preserve optins storage' do
        2.times {joe.optin! :facebook}
        assert {joe.optins.size == 1}
      end
    end
    describe "querying for option with optin?" do
      it "returns true if user is in for feature" do
        joe.optin! :twitter
        assert {joe.optin?(:twitter)}
        assert {joe.optin?('twitter')}
      end
      it "returns false if feature is not opted in" do
        deny {joe.optin?(:sponsor)}
      end
    end
  end
  
  describe "reviewing feature" do
    touch_db_with(:john) {Fabricate(:user)}
    touch_db_with(:explained) {Fabricate(:session)}
    it "john can rate session with 5 stars" do
      john.rate(explained, :stars => 5)
      assert {explained.ratings.first.user == john}
    end
  end
  
  describe "buy/sell" do
    let(:product) {Fabricate.build(:product)}
    let(:john) {Fabricate.build(:user)}
    it "buy builds a BID order with self as user" do
      buy = john.buy(10, product, 220)
      assert {buy.side == Order::Side::BID}
      assert {buy.product == product}
      assert {buy.quantity == 10}
      assert {buy.price == 220}
      assert {buy.user == john}
      assert {buy.new_record?}
    end
    it "sell builds a ASK order with self as user" do
      sell = john.sell(10, product, 0)
      assert {sell.side == Order::Side::ASK}
      assert {sell.product == product}
      assert {sell.quantity == 10}
      assert {sell.price == 0}
      assert {sell.user == john}
      assert {sell.new_record?}
    end
  end
end
